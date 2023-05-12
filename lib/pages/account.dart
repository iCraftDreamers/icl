import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';

import '../controller/account.dart';
import '../theme.dart';
import '/utils/auth/offline/skin.dart';
import '/utils/auth/accounts.dart';
import '/utils/auth/microsoft/microsoft_account.dart';
import '/utils/auth/offline/offline_account.dart';
import '/utils/auth/account.dart';
import '/widgets/page.dart';
import '/widgets/dialog.dart';
import '/widgets/typefield.dart';

class AccountPage extends RoutePage {
  const AccountPage({super.key});

  @override
  String routeName() => "用户";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      children: [
        Row(
          children: [
            title(),
            const Spacer(),
            ElevatedButton(
              onPressed: () => showDialog(
                context: Get.context!,
                builder: (context) => const _AddAccountDialog(),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text("添加用户"),
                    SizedBox(width: 7),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
          final children = <Widget>[];
          for (int i = 0; i < Accounts.list.length; i++) {
            children.add(
              _AccountItem(
                account: Accounts.list[i],
                isSelected: i == controller.currentIndex.value,
                onTap: () => controller.currentIndex(i),
              ),
            );
          }
          return Column(children: children);
        }),
      ],
    );
  }
}

class _AccountItem extends StatefulWidget {
  const _AccountItem({required this.account, this.isSelected, this.onTap});

  final Account account;
  final bool? isSelected;
  final void Function()? onTap;

  @override
  State<_AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<_AccountItem> {
  final _streamController = StreamController<Uint8List>();
  bool _isPressed = false;
  final List<BoxShadow> boxShadow = const [
    BoxShadow(
      color: Colors.black26, // 阴影的颜色
      offset: Offset(0, 5), // 阴影与容器的距离
      blurRadius: 15.0, // 高斯的标准偏差与盒子的形状卷积。
      spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
    ),
  ];

  @override
  void initState() {
    widget.account.skin.u8l
        .then((value) => _streamController.add(Skin.drawAvatar(value!)));
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).extension<ShadowButtonTheme>()!.background!;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final fontColor = widget.isSelected ?? false ? Colors.white : null;
    selectedColor() {
      final r = primaryColor.red + 25;
      final g = primaryColor.green + 25;
      final b = primaryColor.blue;
      return Color.fromARGB(255, r, g, b);
    }

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (details) => setState(() => _isPressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          height: 60,
          margin: EdgeInsets.fromLTRB(
            _isPressed ? 5 : 0,
            _isPressed ? 5 : 0,
            _isPressed ? 5 : 0,
            _isPressed ? 10 : 15,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            borderRadius: MyTheme.borderRadius,
            color: widget.isSelected ?? false
                ? primaryColor
                : _isPressed
                    ? selectedColor()
                    : backgroundColor,
            boxShadow: _isPressed ? null : boxShadow,
          ),
          child: Row(
            children: [
              Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // 阴影的颜色
                          blurRadius: 10.0, // 高斯的标准偏差与盒子的形状卷积。
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: StreamBuilder<Uint8List>(
                      stream: _streamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: 36,
                            height: 36,
                            child: Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return const SizedBox(width: 36, height: 36);
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.account.username,
                        style: TextStyle(
                          color: fontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.account is OfflineAccount
                            ? "离线账号"
                            : widget.account is MicrosoftAccount
                                ? "微软账号"
                                : "未知账号",
                        style: TextStyle(color: fontColor),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Theme(
                data: widget.isSelected ?? false
                    ? ThemeData(brightness: Brightness.dark)
                    : Theme.of(context),
                child: Wrap(
                  spacing: 5,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.checkroom_rounded),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => showDialog(
                        context: Get.context!,
                        builder: (context) => WarningDialog(
                          title: const Text("移除用户"),
                          content: const Text("你确定要移除这个用户吗？此操作将无法撤销！"),
                          onConfirmed: () {
                            Accounts.list.remove(widget.account);
                            Get.back();
                            ScaffoldMessenger.of(Get.context!).showSnackBar(
                              const SnackBar(
                                content: Text("删除成功！"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          onCanceled: () => Get.back(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddAccountDialog extends StatelessWidget {
  const _AddAccountDialog();

  @override
  Widget build(BuildContext context) {
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var loginMode = AccountLoginMode.offline.obs;

    List<Widget> children(AccountLoginMode loginMode) {
      switch (loginMode) {
        case AccountLoginMode.offline:
          return [
            TitleTextFormFiled(
              titleText: "用户名：",
              titleWidth: 75,
              obscureText: false,
              readOnly: false,
              textEditingController: username,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
          ];
        // TODO: 正版验证
        case AccountLoginMode.ms:
          return [];
        case AccountLoginMode.custom:
          return [];
      }
    }

    const items = ["离线账户", "微软账户", "外置登录"];
    final dropdownItems = <DropdownMenuItem>[];
    for (int i = 0; i < items.length; i++) {
      dropdownItems.add(
        DropdownMenuItem(
          value: AccountLoginMode.values[i],
          child: Container(
            alignment: Alignment.center,
            child: Text(
              items[i],
              style: Get.textTheme.titleSmall,
            ),
          ),
        ),
      );
    }
    return Dialog(
      title: const Text("添加用户", style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 75,
                  child: Text("登录方式:"),
                ),
                SizedBox(
                  width: 100,
                  child: Obx(
                    () => DropdownButton(
                      borderRadius: BorderRadius.circular(7.5),
                      isExpanded: true,
                      value: loginMode.value,
                      items: dropdownItems,
                      onChanged: (value) => loginMode(value),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Obx(
              () => Form(
                key: formKey,
                child: Column(
                  children: children(loginMode.value),
                ),
              ),
            ),
          ],
        ),
      ),
      onConfirmed: () {
        if (formKey.currentState!.validate()) {
          switch (loginMode.value) {
            case AccountLoginMode.offline:
              Accounts.add(OfflineAccount(username.text));
            // TODO: 正版验证
            case AccountLoginMode.ms:
            // TODO: 第三方登录
            case AccountLoginMode.custom:
          }
          Get.back();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
                content: Text("添加成功！"), duration: Duration(seconds: 1)),
          );
        }
      },
      onCanceled: () => Get.back(),
    );
  }
}
