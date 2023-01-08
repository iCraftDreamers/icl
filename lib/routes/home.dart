import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "主页",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "账号",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "游戏",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              )
              // TextField(
              //   focusNode: focusNode,
              //   controller: nameController,
              //   onChanged: (str) {
              //     print("onChanged $str");
              //     controller.id.value = str;
              //   },
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.blue),
              //       // borderRadius: BorderRadius.only(
              //       //     topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black54),
              //       // borderRadius: BorderRadius.only(
              //       //     topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
              //     ),
              //     labelText: '用户名',
              //     labelStyle: TextStyle(color: Colors.black54),

              //     suffixIcon: Icon(Icons.done),

              //     // prefixText: "ID  ",
              //     // prefixStyle: TextStyle(color: Colors.blue),
              //     prefixIcon: Icon(Icons.person_outline),

              //     fillColor: Color(0x110099ee),
              //     filled: true,

              //     //  errorText: "error",
              //     //  errorMaxLines: 1,
              //     //  errorStyle: TextStyle(color: Colors.red),
              //     //  errorBorder: UnderlineInputBorder(),

              //     hintText: "请输入用户名",
              //     hintMaxLines: 1,
              //     hintStyle: TextStyle(color: Colors.black87),
              //   ),
              // ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
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
          ),
        ],
      ),
    );
  }
}
