import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/utils/accounts.dart';
import 'package:icl/utils/get_game.dart';
import 'package:icl/utils/get_java.dart';
import 'package:icl/utils/sysinfo.dart';

import '/widgets/page.dart';

class SettingPage extends RoutePage {
  const SettingPage({super.key});

  @override
  String routeName() => "设置";

  @override
  Widget build(BuildContext context) {
    var mem = 1024.obs;
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        title(),
        Obx(() => Text("内存分配大小：${mem.value} MB")),
        Obx(
          () => Slider(
            value: mem.value.toDouble(),
            min: 0,
            max:
                (Sysinfo.getTotalPhysicalMemory ~/ Sysinfo.megaByte).toDouble(),
            label: mem.toString(),
            onChanged: (value) => mem(value.toInt()),
          ),
        ),
        Row(
          children: [
            FilledButton(
              onPressed: () => GetJava.list.forEach((java) => print(java)),
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
              onPressed: () => print(GameManaging.installedGames),
              child: const Text("打印搜索到的游戏"),
            ),
            FilledButton(
              onPressed: () => print(Accounts.list),
              child: const Text("打印存储的账号"),
            ),
          ],
        ),
      ],
    );
  }
}
