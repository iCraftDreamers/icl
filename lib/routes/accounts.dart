import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/accounts.dart';
import '/utils/accounts.dart';
import '/widgets/dialog.dart';
import '/widgets/theme.dart';
import '/widgets/typefield.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  Widget accountsItem(user) {
    String loginModeString(loginmode) {
      switch (loginmode) {
        case 1:
          return "正版登录";
        case 2:
          return "外置登录";
        default:
          return "离线登录";
      }
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7.5)),
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
              Image.asset('steve.png', height: 35, width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['username'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(loginModeString(user['loginmode']))
                ],
              ),
            ],
          ),
          Spacer(),
          Wrap(
            spacing: 10,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () => AccountManaging.removeAccount(user),
                  icon: Icon(Icons.delete)),
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
            const Text("用户列表", style: TextStyle(fontSize: 32)),
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
    final c = Get.put(AccountsController());
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();
    const data = {
      0: '离线登录',
      1: '正版登录',
      2: '外置登录',
    };

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
                const Text("登录方式:"),
                const SizedBox(width: 15),
                SizedBox(
                  width: 100,
                  child: Obx(
                    () => DropdownButton(
                      borderRadius: BorderRadius.circular(7.5),
                      isExpanded: true,
                      value: c.loginMode.value,
                      items: data.keys
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data[value]!,
                                  style: Get.textTheme.titleSmall,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => c.loginMode(value),
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
                  children: children(c.loginMode.value),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        DialogConfirmButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            AccountManaging.addAccount(username.text, password.text);
            Get.back();
          }
        }),
        DialogCancelButton(onPressed: () => Get.back())
      ],
    );
  }
}
