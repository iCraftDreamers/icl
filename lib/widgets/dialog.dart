import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/home.dart';

class AddGameDialog extends StatelessWidget {
  const AddGameDialog({super.key});

  Widget textField(Widget left, String lable) {
    return Row(
      children: [
        left,
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(lable),
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
              Text("添加游戏", style: TextStyle(fontSize: 24)),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: const Icon(Icons.file_open),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Java路径"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Minecraft路径"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    //初始化对话框
    return Dialog(
      // backgroundColor: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) {
    //给对话框放入内容
    return SizedBox(
      width: 520,
      // height: 666,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBar(),
          const Divider(height: 1),
          _buildChoiseMethod(),
          _buildImportUsername(),
          const Divider(height: 1),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildBar() {
    //标题
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

  Widget _buildChoiseMethod() {
    Get.put(HomeController());
    // 选择登录方式的下拉框
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          width: 80,
          child: Text("登录方式: "),
        ),
        SizedBox(
            width: 200,
            child: GetBuilder<HomeController>(
              builder: (c) => DropdownButton(
                isExpanded: true, //下拉箭头靠右
                value: c.loginMode,
                items: HomeController.data
                    .map(
                      (item) => DropdownMenuItem(
                          value: item,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(item['name']))),
                    )
                    .toList(),
                onChanged: (value) => c.updateLoginMode(value),
              ),
            ))
      ]),
    );
  }
}

Widget _buildImportUsername() {
  //离线模式用户名
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
      SizedBox(width: 80, child: Text("用户名: ")),
      SizedBox(
          width: 200,
          child: Expanded(
              child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // labelText: '用户名',
            ),
          )))
    ]),
  );
}

Widget _buildFooter(context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0, top: 10, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Theme.of(context).primaryColor,
          ),
          child: const Text('添加', style: TextStyle(fontSize: 16)),
        ),
        InkWell(
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
