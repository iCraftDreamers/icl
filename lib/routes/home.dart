import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/widgets/dialog.dart';

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
              builder: (context) => const LoginDialog(),
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
              builder: (context) => const AddGameDialog(),
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

  Widget gridView() {
    final data = List.generate(20, (index) => Color(0xFFBAABBA - 2 * index));
    return GridView.extent(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(children: [gridView()])
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: FloatingActionButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        initialDirectory: 'C:',
                        allowedExtensions: ['exe'],
                      );
                      if (result != null) {
                        File file = File(result.files.single.path.toString());
                        print(file);
                      } else {
                        print("Exit");
                      }
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        toolBar(),
      ],
    );
  }
}
