import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '/widgets/page.dart';

class HomePage extends BasePage with BasicPage {
  const HomePage({super.key});

  @override
  String pageName() => "主页";

  Widget body() {
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
    return Stack(
      children: [
        ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [head(), body()],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: FloatingActionButton(
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
              child: const Icon(Icons.play_arrow),
            ),
          ),
        ),
      ],
    );
  }
}
