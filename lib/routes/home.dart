import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/utils/file_picker.dart';
import 'package:icl/utils/get_game.dart';
import 'package:icl/widgets/theme.dart';

import '../widgets/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Row(
          children: [
            Text("游戏列表", style: MyTheme.title),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () => GameManaging.init(),
            )
          ],
        ),
        const SizedBox(height: 10),
        gridView(),
      ],
    );
  }

  Widget toolBar() {
    return Container(
      height: 65,
      color: Color.fromARGB(0, 0, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
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

  Widget addGameDialog() {
    final javaDirController = TextEditingController();
    final gameDirController = TextEditingController();

    return AlertDialog(
      title: const Text("添加游戏"),
      content: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTextField(
              icon: Icons.file_open,
              label: "Java路径",
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
              label: "Minecraft路径",
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
        DialogConfirmButton(onPressed: () {}),
        DialogCancelButton(onPressed: () {}),
      ],
    );
  }

  Widget gridView() {
    Widget card(version, [image]) {
      return Card(
        color: Colors.lightBlueAccent,
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          version,
                          style: Get.textTheme.titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    const versions = ["1.8", "1.19.2", "1.12.2"];
    final children = versions.map((e) => card(e)).toList();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1.333,
        shrinkWrap: true,
        children: children,
      ),
    );
  }
}

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onPressed,
  });

  final IconData icon;
  final String label;
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
              label: Text(label),
            ),
          ),
        ),
      ],
    );
  }
}
