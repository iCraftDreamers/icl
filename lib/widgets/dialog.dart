import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/login.dart';
import 'package:imcl/utils/file_picker.dart';
import 'package:imcl/utils/accounts.dart';
import 'package:imcl/widgets/text_field.dart';

class AddGameDialog extends StatelessWidget {
  const AddGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final javaDirController = TextEditingController();
    final gameDirController = TextEditingController();

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.5)),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("添加游戏", style: TextStyle(fontSize: 24)),
            const Divider(),
            const SizedBox(height: 10),
            IconTextField(
              icon: Icons.file_open,
              lable: "Java路径",
              hintText: "java.exe",
              controller: javaDirController,
              onPressed: () async {
                final File file = await filePicker(['exe']);
                javaDirController.text = file.path;
              },
            ),
            const SizedBox(height: 10),
            IconTextField(
              icon: Icons.folder_open,
              lable: "Minecraft路径",
              hintText: ".minecraft",
              controller: gameDirController,
              onPressed: () async {
                final File file = await folderPicker();
                gameDirController.text = file.path;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Row(
        children: const [Text("添加用户", style: TextStyle(fontSize: 24))],
      );
    }

    Widget dropdownButtons() {
      final c = Get.put(LoginController());
      const data = {
        0: '离线模式',
        1: '正版登录',
        2: '外置登录',
      };
      // 选择登录方式的下拉框
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("登录方式 :", style: Get.textTheme.titleSmall),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 200,
            child: Obx(
              () => DropdownButton(
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
      );
    }

    Widget typefield(String title, TextEditingController controller,
        [String? descirbe]) {
      //定义输入框, title 为输入框前的标题, describe为输入框内的描述
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: Get.textTheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: descirbe ?? "",
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget textFieldBar() {
      //选择不同的登录方法时,展示的内容
      final c = Get.put(LoginController());
      List<Widget> children(int loginMode) {
        switch (loginMode) {
          case 1:
            return [];
          case 2:
            return [
              typefield("用户名 :", c.loginUsername),
              typefield("密码 :", c.loginPassword)
            ];
          default:
            return [typefield("用户名 :", c.loginUsername)];
        }
      }

      return SizedBox(
        // height: 300,
        child: Obx(
          () => Column(children: children(c.loginMode.value)),
        ),
      );
    }

    Widget footer() {
      void addAccount() {
        final acc = AccountsManaging();
        final c = Get.put(LoginController());
        switch (c.loginMode.value) {
          case 1:
            // users.add([c.loginMode.value, c.loginUsername]);
            break;
          case 2:
            // users.add([c.loginMode.value, c.loginUsername, c.loginPassword]);
            break;
          default:
            acc.add({
              "loginMode": c.loginMode.value,
              "username": c.loginUsername.text
            });
            break;
        }
        print(acc.accounts);
      }

      //底部的按钮
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => addAccount(),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('添加', style: TextStyle(fontSize: 16)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text('取消', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      );
    }

    return Dialog(
      //初始化对话框
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.5))),
      child: Container(
        width: 391,
        padding: const EdgeInsets.all(15),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            title(),
            const Divider(),
            dropdownButtons(),
            const SizedBox(height: 10),
            textFieldBar(),
            const Spacer(),
            const Divider(),
            footer(),
          ],
        ),
      ),
    );
  }
}
