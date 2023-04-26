import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/auth/offline/skin.dart';
import '/utils/auth/accounts.dart';
import '/utils/auth/microsoft/microsoft_account.dart';
import '/utils/auth/offline/offline_account.dart';
import '/utils/auth/account.dart';
import '/widgets/page.dart';
import '/widgets/shadow_box_decoration.dart';
import '/widgets/dialog.dart';
import '/widgets/typefield.dart';

class AccountPage extends RoutePage {
  const AccountPage({super.key});

  @override
  String routeName() => "用户";

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: const [
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
        Obx(
          () => Column(
            children:
                Accounts.list.map((acc) => _AccountItem(account: acc)).toList(),
          ),
        ),
      ],
    );
  }
}

class _AccountItem extends StatelessWidget {
  const _AccountItem({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: ShadowBoxDecoration(Get.context!),
      child: Row(
        children: [
          Wrap(
            spacing: 15,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FutureBuilder<Uint8List?>(
                // TODO: 正版账号皮肤获取
                // account is OfflineAccount ? (account as OfflineAccount).skin.avatar : getSkin(account)
                future: account.skin.u8l,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image.memory(
                      Skin.drawAvatar(snapshot.data!),
                      width: 40,
                      height: 40,
                    );
                  }
                  return Container(
                    color: Colors.grey.withOpacity(.1),
                    height: 40,
                    width: 40,
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    account is OfflineAccount
                        ? "离线账号"
                        : account is MicrosoftAccount
                            ? "微软账号"
                            : "未知账号",
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Wrap(
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
                    title: "移除用户",
                    content: "你确定要移除这个用户吗？此操作将无法撤销！",
                    onConfirmed: () {
                      Accounts.list.remove(account);
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
        ],
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
    var loginMode = 0.obs;

    List<Widget> children(int loginMode) {
      switch (loginMode) {
        case 1:
          return [];
        case 2:
          return [
            TitleTextFormFiled(
              titleText: "用户名：",
              titleWidth: 75,
              obscureText: false,
              readOnly: false,
              textEditingController: username,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
            const SizedBox(height: 15),
            TitleTextFormFiled(
              titleText: "密码：",
              titleWidth: 75,
              obscureText: true,
              readOnly: false,
              textEditingController: password,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
          ];
        default:
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
      }
    }

    const items = ["离线账户", "微软账户", "外置登录"];
    final dropdownItems = <DropdownMenuItem>[];
    for (int i = 0; i < items.length; i++) {
      dropdownItems.add(
        DropdownMenuItem(
          value: i,
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
    return AlertDialog(
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
      actions: [
        DialogConfirmButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            switch (loginMode.value) {
              case 0:
                Accounts.add(OfflineAccount(username.text));
                break;
              default:
            }
            Get.back();
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(
                  content: Text("添加成功！"), duration: Duration(seconds: 1)),
            );
          }
        }),
        DialogCancelButton(onPressed: () => Get.back())
      ],
    );
  }
}

enum AccountLoginMode {
  offline,
  ms,
  custom,
}
