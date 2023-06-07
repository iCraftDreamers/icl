import 'dart:math';

import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';
import 'package:icl/controller/storage.dart';
import 'package:icl/theme.dart';
import 'package:icl/widgets/dialog.dart';
import 'package:icl/widgets/typefield.dart';
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
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: title(),
        ),
        SizedBox(
          height: 30,
          child: GetBuilder(
            init: _TabController(),
            builder: (c) => TabBar(
              isScrollable: true,
              controller: c.tabController,
              tabs: c.tabs.keys.map((text) => Tab(text: text)).toList(),
            ),
          ),
        ),
        Expanded(
          child: GetBuilder(
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
  const _GlobalGameSettingPage();

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigController>();
    final globalSetting = configController.data['globalGameSetting'];
    var autoAllocationMemory =
        (globalSetting['autoAllocationMemory'] as bool).obs;
    var allocationMemory = (globalSetting['allocationMemory'] as int).obs;
    var jvmArgs = (globalSetting['jvmArgs'] as String).obs;
    var defaultJvmArgs = (globalSetting['defaultJvmArgs'] as bool).obs;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final totalMemSize = SysInfo.totalPhyMem / kMegaByte;

    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        TitleWidgetGroup(
          "Java设置",
          children: [
            ListTile(
              title: const Text("Java路径"),
              subtitle: Text(Javas.list[0].path),
            ),
            Obx(
              () => ListTile(
                title: const Text("JVM启动参数"),
                subtitle: Text(jvmArgs.value),
                onTap: () {
                  final jvmArgsController =
                      TextEditingController(text: jvmArgs.value);
                  RxBool isExpaned = false.obs;
                  showDialog(
                    context: Get.context!,
                    builder: (_) => DefaultDialog(
                      title: const Text("JVM启动参数"),
                      onCanceled: () {
                        dialogPop();
                        jvmArgsController.text = jvmArgs.value;
                      },
                      onConfirmed: () {
                        dialogPop();
                        jvmArgs(jvmArgsController.text);
                        globalSetting['jvmArgs'] = jvmArgsController.text;
                        configController.updateConfig();
                      },
                      // TODO: 判断输入正确
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 400,
                            child: DefaultTextFormField(
                              controller: jvmArgsController,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // TODO: 圆角
                          ClipRRect(
                            borderRadius: kBorderRadius,
                            clipBehavior: Clip.antiAlias,
                            child: Obx(
                              () => ExpansionListTile(
                                isExpaned: isExpaned.value,
                                tile: ListTile(
                                  title: const Text("高级"),
                                  onTap: () => isExpaned(!isExpaned.value),
                                  leading: const Icon(Icons.expand_more),
                                ),
                                expandTile: SwitchListTile(
                                  title: const Text("默认参数"),
                                  value: defaultJvmArgs.value,
                                  onChanged: (value) {
                                    defaultJvmArgs(value);
                                    globalSetting['defaultJvmArgs'] = value;
                                    configController.updateConfig();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        ValueBuilder<bool?>(
          initialValue: autoAllocationMemory.value,
          builder: (snapshot, updater) {
            return TitleWidgetGroup(
              "内存设置",
              children: [
                ExpansionListTile(
                  isExpaned: !snapshot!,
                  tile: SwitchListTile(
                    title: const Text("游戏内存"),
                    subtitle: const Text("自动分配"),
                    value: snapshot,
                    selected: !snapshot,
                    hoverColor: colorWithValue(colors.secondaryContainer, -.05),
                    onChanged: (value) {
                      autoAllocationMemory(value);
                      globalSetting['autoAllocationMemory'] = value;
                      configController.updateConfig();
                      updater(value);
                    },
                  ),
                  expandTile: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Text("手动分配"),
                            Expanded(
                              child: Obx(
                                () => Slider(
                                  inactiveColor: colors.primary.withOpacity(.2),
                                  value: allocationMemory.toDouble(),
                                  min: 0,
                                  max: totalMemSize,
                                  label: allocationMemory.toString(),
                                  onChanged: (value) =>
                                      allocationMemory(value.toInt()),
                                  onChangeEnd: (value) {
                                    allocationMemory(value.toInt());
                                    globalSetting['allocationMemory'] =
                                        value.toInt();
                                    configController.updateConfig();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: Obx(
                          () => _MemoryAllocationBar(
                            totalMemSize,
                            SysInfo.freePhyMem / kMegaByte,
                            allocationMemory.toDouble(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        TitleWidgetGroup(
          "测试",
          children: [
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
  const _LauncherSettingPage();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final tabs = {
    "全局游戏设置": const _GlobalGameSettingPage(),
    "启动器": const _LauncherSettingPage(),
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
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
                "使用中内存：${_truncateToDecimalPlaces(usedMemSize / 1024, 1)} / ${_truncateToDecimalPlaces(totalMemSize / 1024, 1)} GB"),
            const Spacer(),
            Text(
                "游戏分配：${_truncateToDecimalPlaces(allocationMemSize / 1024, 1)} GB ${allocationMemSize > freeMemSize ? "(${_truncateToDecimalPlaces(freeMemSize / 1024, 1)} GB 可用)" : ""}"),
          ],
        ),
      ],
    );
  }
}

double _truncateToDecimalPlaces(num value, int fractionalDigits) =>
    (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
