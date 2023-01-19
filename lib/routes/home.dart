import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '/widgets/page.dart';

class HomePage extends BasePage with BasicPage {
  const HomePage({super.key});

  @override
  String pageName() => "主页";

  Widget body() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
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
        child: const Text('开始游戏'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [head(), body()],
    );
  }
}
