import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controllers/accounts.dart';
import '../utils/accounts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  // get groupValue => null;

  // get onChanged => null;

  // get value => null;
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
            child: Align(alignment: Alignment.centerRight, child: Text(title)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '此处不得留空！';
                }
                return null;
              },
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
          onPressed: () {
            if (c.formKey.currentState!.validate()) {
              c.addAccount();
              Get.back();
              c.loginUsername.clear();
              c.loginPassword.clear();
            }
          },
          child: const Text("确定", style: TextStyle(fontSize: 16)),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("取消", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget deleteAccountDialog(Map user) {
    return AlertDialog(
      title: Text("移除账号",
          style: TextStyle(
              color: Color.fromARGB(238, 248, 97, 95),
              fontWeight: FontWeight.bold)),
      content: Text(
        "确定要移除这个账号吗？此操作将无法撤销！",
      ),
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 255, 117, 117),
          ),
          onPressed: () {
            AccountsManaging().delete(user);
            Get.back();
          },
          child: const Text("确定", style: TextStyle(fontSize: 16)),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("取消", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var value;
    var groupValue;
    var onChanged;
    List<Widget> searchAccounts(List<Map> acc) {
      List<Widget> children = [];
      acc.forEach((e) {
        children.add(
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  border: Border.all(
                    color: Colors.black12,
                  )),
              child: Row(
                children: [
                  // const SizedBox(width: 5),
                  Radio(
                      value: value,
                      groupValue: groupValue,
                      onChanged: (value) => onChanged.value),
                  Image.asset(
                    'steve.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        e['username'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => {
                      showDialog(
                          context: Get.context!,
                          builder: (context) => deleteAccountDialog(e))
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
      return children;
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                children: [
                  const Text("账号列表", style: TextStyle(fontSize: 32)),
                  const Spacer(),
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
                          Text("添加账号"),
                          SizedBox(width: 7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: searchAccounts(AccountsManaging.gameAccounts),
              )
            ],
          ),
        ),
        // const Divider(height: 1),
      ],
    );
  }
}
