import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/accounts.dart';
import 'package:imcl/utils/file_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget toolBar() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => showDialog(
              context: Get.context!,
              builder: (context) => addAccountsDialog(),
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
          const Spacer(),
          ElevatedButton(
            onPressed: () => showDialog(
              context: Get.context!,
              builder: (context) => addGameDialog(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  Text("添加游戏"),
                  SizedBox(width: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addAccountsDialog() {
    final c = Get.put(AccountsController());
    const data = {
      0: '离线模式',
      1: '正版登录',
      2: '外置登录',
    };

    Widget typefield(
        String title, TextEditingController controller, bool obscureText) {
      //定义输入框, title 为输入框前的标题, describe为输入框内的描述
      return Row(
        children: [
          SizedBox(
              width: 60,
              child:
                  Align(alignment: Alignment.centerRight, child: Text(title))),
          const SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: (value) => c.userNameValidator(value!),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.5))),
              ),
            ),
          ),
        ],
      );
    }

    List<Widget> children(int loginMode) {
      switch (loginMode) {
        case 1:
          return [];
        case 2:
          return [
            typefield("用户名:", c.loginUsername, false),
            const SizedBox(height: 15),
            typefield("密码:", c.loginPassword, true)
          ];
        default:
          return [typefield("用户名:", c.loginUsername, false)];
      }
    }

    return AlertDialog(
      title: const Text("添加用户"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                key: c.formKey,
                child: Column(
                  children: children(c.loginMode.value),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () {},
            child: const Text("确定", style: TextStyle(fontSize: 16))),
        TextButton(
            onPressed: () => Get.back(),
            child: const Text("取消", style: TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget addGameDialog() {
    final javaDirController = TextEditingController();
    final gameDirController = TextEditingController();

    return AlertDialog(
      title: const Text("添加游戏"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTextField(
              icon: Icons.file_open,
              lable: "Java路径",
              hintText: "java.exe",
              controller: javaDirController,
              onPressed: () async {
                final File? file = await filePicker(['exe']);
                javaDirController.text = file!.path;
              },
            ),
            const SizedBox(height: 10),
            IconTextField(
              icon: Icons.folder_open,
              lable: "Minecraft路径",
              hintText: ".minecraft",
              controller: gameDirController,
              onPressed: () async {
                final File? file = await folderPicker();
                gameDirController.text = file!.path;
              },
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () {},
            child: const Text("确定", style: TextStyle(fontSize: 16))),
        TextButton(
            onPressed: () => Get.back(),
            child: const Text("取消", style: TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget gridView() {
    final data = List.generate(20, (index) => Color(0xFFBAABBA - 2 * index));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.333,
        shrinkWrap: true,
        children: data
            .map(
              (e) => Card(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                children: [
                  const Text("游戏列表", style: TextStyle(fontSize: 32)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 10),
              gridView(),
            ],
          ),
        ),
        const Divider(height: 1),
        toolBar(),
      ],
    );
  }
}

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.lable,
    required this.hintText,
    required this.controller,
    this.onPressed,
  });

  final IconData icon;
  final String lable;
  final String hintText;
  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed ?? () {},
          icon: Icon(icon),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5))),
              hintText: hintText,
              label: Text(lable),
            ),
          ),
        ),
      ],
    );
  }
}
