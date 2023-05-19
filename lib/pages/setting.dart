import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/widget_group.dart';

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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final maxMemSize = (SysInfo.totalPhyMem ~/ kMegaByte).toDouble();
    var mem = 1024.obs;
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        WidgetGroup(
          divider: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              height: 1,
              color: Theme.of(context)
                  .colorScheme
                  .onSecondaryContainer
                  .withOpacity(.2),
            ),
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
                  ValueBuilder<bool?>(
                    initialValue: false,
                    builder: (value, updater) => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("自动分配内存"),
                      value: value!,
                      onChanged: (value) => updater(value),
                    ),
                  ),
                  Obx(() {
                    final freePhyMem = SysInfo.freePhyMem;
                    final bodyMedia = theme.textTheme.bodyMedium;
                    final warning = mem.value > freePhyMem ~/ kMegaByte * .8;
                    return Row(
                      children: [
                        RichText(
                          text: TextSpan(style: bodyMedia, children: [
                            const TextSpan(text: '内存分配大小：'),
                            TextSpan(
                                text: '${mem.value}',
                                style: TextStyle(
                                    color: warning ? Colors.red : null)),
                            const TextSpan(text: ' / '),
                            TextSpan(
                                text: '${freePhyMem ~/ kMegaByte}',
                                style: TextStyle(color: Colors.green[400])),
                            const TextSpan(text: ' / '),
                            TextSpan(
                                text: '${maxMemSize.toInt()}',
                                style: TextStyle(color: Colors.yellow[600])),
                            const TextSpan(text: ' MB'),
                          ]),
                        ),
                        if (warning)
                          const Icon(Icons.warning_rounded, size: 20),
                      ],
                    );
                  }),
                  Obx(
                    () => Slider(
                      inactiveColor: colors.primary.withOpacity(.2),
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
