import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/theme.dart';
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
    final totalMemSize = SysInfo.totalPhyMem / kMegaByte;
    var mem = 1024.0.obs;
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
                      title: const Text("自动分配内存"),
                      value: value!,
                      onChanged: (value) => updater(value),
                    ),
                  ),
                  Obx(
                    () => Slider(
                      inactiveColor: colors.primary.withOpacity(.2),
                      value: mem.value,
                      min: 0,
                      max: totalMemSize,
                      label: mem.toString(),
                      onChanged: (value) => mem(value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => _MemoryAllocationBar(
                      totalMemSize, SysInfo.freePhyMem / kMegaByte, mem.value))
                ],
              ),
            ),
            ListTile(
              title: Row(
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

class _MemoryAllocationBar extends StatelessWidget {
  // const _MemoryAllocationBar();
  const _MemoryAllocationBar(
      this.totalMemSize, this.freeMemSize, this.allocationMemSize);

  final double totalMemSize;
  final double freeMemSize;
  final double allocationMemSize;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final allocationMemPercent = allocationMemSize / totalMemSize;
    final usedMemSize = totalMemSize - freeMemSize;
    final usedPercent = usedMemSize / totalMemSize;
    return Column(
      children: [
        SizedBox(
          height: 5,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: kBorderRadius,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(.2),
                    borderRadius: kBorderRadius,
                  ),
                ),
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 100),
                  widthFactor: usedPercent + allocationMemPercent,
                  child: Container(color: colors.primary.withOpacity(.3)),
                ),
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 100),
                  widthFactor: usedPercent,
                  child: Container(color: colors.primary),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Text(
                "使用中内存：${_truncateToDecimalPlaces(usedMemSize / 1024, 1)} / ${_truncateToDecimalPlaces(totalMemSize / 1024, 1)} GB"),
            const Spacer(),
            Text(
                "分配内存：${_truncateToDecimalPlaces(allocationMemSize / 1024, 1)} GB"),
          ],
        ),
      ],
    );
  }
}

double _truncateToDecimalPlaces(num value, int fractionalDigits) =>
    (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
