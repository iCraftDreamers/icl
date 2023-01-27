import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/login.dart';
import 'package:imcl/utils/file_picker.dart';

class AddGameDialog extends StatelessWidget {
  const AddGameDialog({super.key});

  Widget textField(IconData icon, String lable, String hintText,
      [Function? onPressed]) {
    return Row(
      children: [
        IconButton(onPressed: () => onPressed!(), icon: Icon(icon)),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            height: 42,
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                ),
                hintText: hintText,
                label: Text(lable),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.5)),
      ),
      child: SizedBox(
        width: 400,
        height: 800,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("添加游戏", style: TextStyle(fontSize: 24)),
              const Divider(),
              const SizedBox(height: 10),
              textField(Icons.file_open, "Java路径", "java.exe",
                  () => filePicker(["exe"])),
              const SizedBox(height: 10),
              textField(Icons.folder_open, "Minecraft路径", ".minecraft",
                  () => folderPicker()),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginDialog extends StatelessWidget {
  //添加登录方式对话框
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: const [
            Text(
              "添加用户",
              style: TextStyle(color: Color(0xff5CC5E9), fontSize: 24),
            ),
          ],
        ),
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
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 80, child: Text("登录方式: ")),
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
                            child: Text(data[value]!),
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
      );
    }

    Widget containerOfAuth() {
      //选择不同的登录方法时,展示的内容
      Widget typefield(String title, String descirbe) {
        //定义输入框, title 为输入框前的标题, describe为输入框内的描述
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 80, child: Text(title)),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: ImporterCotroller().getUsername,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: descirbe,
                  ),
                ),
              )
            ],
          ),
        );
      }

      List<Widget> children(int loginMode) {
        switch (loginMode) {
          case 1:
            return [];
          case 2:
            return [typefield("用户名", ""), typefield("密码", "")];
          default:
            return [typefield("用户名: ", "")];
        }
      }

      final c = Get.put(LoginController());

      return SizedBox(
        height: 300,
        child: Obx(
          () => Column(children: children(c.loginMode.value)),
        ),
      );
    }

    void saving() {
      print("Hi WDNMD");
      final importerController = ImporterCotroller();
      print(importerController.getUsername.text);
    }

    Widget footer(context) {
      //底部的按钮
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 15, top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onTap: () => saving(),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).highlightColor,
                ),
                child: const Text('添加', style: TextStyle(fontSize: 16)),
              ),
            ),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).highlightColor,
                ),
                child: const Text('取消', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      );
    }

    return Dialog(
      //初始化对话框
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title(),
            const Divider(height: 1),
            dropdownButtons(),
            containerOfAuth(),
            const Divider(height: 1),
            footer(context)
          ],
        ),
      ),
    );
  }
}
