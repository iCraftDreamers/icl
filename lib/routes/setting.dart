import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/utils/accounts.dart';
import 'package:icl/utils/get_game.dart';
import 'package:icl/utils/get_java.dart';

import '/widgets/page.dart';

class SettingPage extends BasePage with BasicPage {
  const SettingPage({super.key});

  @override
  String pageName() => "设置";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        head(context),
        ValueBuilder<double?>(
          initialValue: 1024,
          builder: (value, updater) => Slider(
            value: value!,
            min: 512,
            max: 4096,
            divisions: 7,
            label: value.toInt().toString(),
            onChanged: (value) => updater(value),
          ),
        ),
        Row(
          children: [
            FilledButton(
              onPressed: () => print(GetJava.javas),
              child: const Text("测试"),
            ),
            FilledButton(
              onPressed: () {
                GameManaging.init();
                GetJava.init();
              },
              child: const Text("搜索游戏"),
            ),
            FilledButton(
              onPressed: () {
                showDialog(
                  context: Get.context!,
                  builder: (context) => SimpleDialog(
                    title: Text("测试"),
                    children: [Text(GameManaging.installedGames.toString())],
                  ),
                );
              },
              child: const Text("打印搜索到的游戏"),
            ),
            FilledButton(
              onPressed: () => print(AccountManaging.gameAccounts),
              child: const Text("打印存储的账号"),
            ),
          ],
        ),
      ],
    );
  }
}
