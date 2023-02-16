import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/skintoavatar.dart';
import '/utils/accounts.dart';
import '/widgets/dialog.dart';
import '/widgets/theme.dart';
import '/widgets/typefield.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Widget accountsItem(user) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        color: Get.theme.extension<ShadowButtonTheme>()!.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2), // 阴影的颜色
            offset: Offset(0, 5), // 阴影与容器的距离
            blurRadius: 10.0, // 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
          ),
        ],
      ),
      child: Row(
        children: [
          Wrap(
            spacing: 15,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.memory(
                Skin.toAvatar("E:\\14197123560897983338.png"),
                width: 40,
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['username'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(AccountManaging.loginModes[user["loginmode"]].toString())
                ],
              ),
            ],
          ),
          Spacer(),
          Wrap(
            spacing: 5,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => showDialog(
                  context: Get.context!,
                  builder: (context) => WarningDialog(
                    title: "删除账号",
                    content: "你确定要删除这个账号吗？此操作将无法撤销！",
                    onConfirmed: () {
                      AccountManaging.removeAccount(user);
                      Get.back();
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Row(
          children: [
            const Text("账号管理", style: TextStyle(fontSize: 32)),
            const Spacer(),
            ElevatedButton(
              onPressed: () => showDialog(
                context: Get.context!,
                builder: (context) => AddAccountDialog(),
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
            children: AccountManaging.gameAccounts
                .map((element) => accountsItem(element))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class AddAccountDialog extends StatelessWidget {
  const AddAccountDialog({super.key});

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
            MyTextFormField(
              obscureText: false,
              textEditingController: username,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
            const SizedBox(height: 15),
            MyTextFormField(
              obscureText: true,
              textEditingController: password,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
          ];
        default:
          return [
            MyTextFormField(
              obscureText: false,
              textEditingController: username,
              validator: (value) => MyTextFormField.checkEmpty(value),
            ),
          ];
      }
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
                  width: 80,
                  child: Text("登录方式:"),
                ),
                SizedBox(
                  width: 100,
                  child: Obx(
                    () => DropdownButton(
                      borderRadius: BorderRadius.circular(7.5),
                      isExpanded: true,
                      value: loginMode.value,
                      items: AccountManaging.loginModes.keys
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AccountManaging.loginModes[value]!,
                                  style: Get.textTheme.titleSmall,
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
            AccountManaging.add(
              username.text,
              password.text,
              loginMode.value,
            );
            Get.back();
          }
        }),
        DialogCancelButton(onPressed: () => Get.back())
      ],
    );
  }
}
