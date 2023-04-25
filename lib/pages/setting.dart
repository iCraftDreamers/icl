import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/auth/accounts.dart';
import '/utils/game/game.dart';
import '/utils/game/java.dart';
import '/utils/sysinfo.dart';
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
              onPressed: () => Javas.list.forEach((java) => print(java)),
              child: const Text("测试"),
            ),
            FilledButton(
              onPressed: () {
                Games.init();
                Javas.init();
              },
              child: const Text("搜索游戏"),
            ),
            FilledButton(
              onPressed: () => print(Games.installedGames),
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
