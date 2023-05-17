import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/widget_set.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          child: title(),
        ),
        SizedBox(
          height: 30,
          child: GetBuilder<_TabController>(
            init: _TabController(),
            builder: (c) => TabBar(
              isScrollable: true,
              controller: c.tabController,
              tabs: c.tabs.keys.map((text) => Tab(text: text)).toList(),
            ),
          ),
        ),
        Expanded(
          child: GetBuilder<_TabController>(
            init: _TabController(),
            builder: (c) => TabBarView(
              controller: c.tabController,
              children: c.tabs.values.toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlobalGameSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mem = 1024.obs;
    final maxMemSize = (SysInfo.totalPhyMem ~/ kMegaByte).toDouble();
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        WidgetSet(
          divider: const Divider(height: 1),
          dividerPadding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: const Color.fromRGBO(77, 77, 77, 1),
          ),
          clipBehavior: Clip.antiAlias,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Java版本优选
            ListTile(
              title: const Text("Java路径"),
              subtitle: Text(Javas.list[0].path),
            ),
            ListTile(
              title: const Text("游戏内存"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Text("内存分配大小：${mem.value} / ${maxMemSize.toInt()} MB"),
                        const SizedBox(width: 15),
                        Text("空闲内存：${SysInfo.freePhyMem ~/ kMegaByte} MB")
                      ],
                    ),
                  ),
                  Obx(
                    () => Slider(
                      value: mem.value.toDouble(),
                      min: 0,
                      max: maxMemSize,
                      label: mem.toString(),
                      onChanged: (value) => mem(value.toInt()),
                    ),
                  ),
                ],
              ),
            ),
            const ListTile(title: Text("第三行")),
          ],
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

class _LauncherSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final tabs = {
    "全局游戏设置": _GlobalGameSettingPage(),
    "启动器": _LauncherSettingPage(),
  };

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
