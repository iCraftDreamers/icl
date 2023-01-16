import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imcl/widgets/page.dart';

class HomePage extends BasePage with BasicPage {
  const HomePage({super.key});

  @override
  String pageName() => "主页";

  @override
  List<Widget> get body => [
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path.toString());
                print(file);
              } else {
                print("Exit");
              }
            },
            child: const Text('开始游戏'),
          ),
        ),
      ];
}
