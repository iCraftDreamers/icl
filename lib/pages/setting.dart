import 'dart:math';

import 'package:flutter/material.dart' hide Dialog;
import 'package:get/get.dart';
import 'package:icl/controller/storage.dart';
import 'package:icl/theme.dart';
import 'package:icl/widgets/dialog.dart';
import 'package:icl/widgets/textfield.dart';
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

  Widget resolutionTextField(String key) {
    final configController = Get.find<ConfigController>();
    final globalGameConfiguration =
        configController.jsonData['globalGameConfiguration'];
    final controller =
        TextEditingController(text: globalGameConfiguration[key].toString());
    void onSubmitted(String key, String value) {
      globalGameConfiguration[key] = int.parse(value);
      configController.updateConfig();
    }

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 4,
      decoration: const InputDecoration(counterText: ""),
      onSubmitted: (value) => onSubmitted(key, value),
      onTapOutside: (_) => onSubmitted(key, controller.text),
    );
  }

  Widget textField(String key) {
    final configController = Get.find<ConfigController>();
    final globalGameConfiguration =
        configController.jsonData['globalGameConfiguration'];
    final controller =
        TextEditingController(text: globalGameConfiguration[key]);
    void onSubmitted(String key, String value) {
      globalGameConfiguration[key] = value;
      configController.updateConfig();
    }

    return TextField(
      controller: controller,
      onSubmitted: (value) => onSubmitted(key, value),
      onTapOutside: (_) => onSubmitted(key, controller.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigController>();
    final globalGameConfiguration =
        configController.jsonData['globalGameConfiguration'];
    var autoMemory = (globalGameConfiguration['autoMemory'] as bool).obs;
    var maxMemory = (globalGameConfiguration['maxMemory'] as int).obs;
    var jvmArgs = (globalGameConfiguration['jvmArgs'] as String).obs;
    var defaultJvmArgs =
        (globalGameConfiguration['defaultJvmArgs'] as bool).obs;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final totalMemSize = SysInfo.totalPhyMem / kMegaByte;

    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        TitleWidgetGroup(
          "Java",
          children: [
            ListTile(
              title: const Text("Java路径"),
              subtitle: GetBuilder<ConfigController>(
                id: "javaPath",
                builder: (c) {
                  var text = (globalGameConfiguration['java'] as String);
                  if (text == "auto") {
                    text = "自动选择最佳版本";
                  }
                  return Text(text);
                },
              ),
              onTap: () => showDialog(
                context: Get.context!,
                builder: (_) {
                  return DefaultDialog(
                    title: const Text("Java路径"),
                    onlyConfirm: true,
                    onConfirmed: () => dialogPop(),
                    content: Material(
                      color: Colors.transparent,
                      borderRadius: kBorderRadius,
                      clipBehavior: Clip.antiAlias,
                      child: GetBuilder<ConfigController>(
                        id: "javaPath",
                        builder: (c) {
                          var groupValue =
                              (globalGameConfiguration['java'] as String);
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                  RadioListTile(
                                    value: "auto",
                                    groupValue: groupValue,
                                    title: const Text("自动选择最佳版本"),
                                    onChanged: (value) {
                                      globalGameConfiguration['java'] = value;
                                      c.updateConfig(["javaPath"]);
                                    },
                                  )
                                ] +
                                Javas.list
                                    .map(
                                      (e) => RadioListTile(
                                        value: e.path,
                                        groupValue: groupValue,
                                        title: Text(e.versionNumber),
                                        subtitle: Text(e.path),
                                        onChanged: (value) {
                                          globalGameConfiguration['java'] =
                                              value;
                                          c.updateConfig(["javaPath"]);
                                        },
                                      ),
                                    )
                                    .toList(),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => ListTile(
                title: const Text("JVM启动参数"),
                subtitle: Text(
                    "${defaultJvmArgs.value ? '默认' : ''}${jvmArgs.value.isEmpty || !defaultJvmArgs.value ? '' : ' + '}${jvmArgs.value}"),
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
                        globalGameConfiguration['jvmArgs'] =
                            jvmArgsController.text;
                        configController.updateConfig();
                      },
                      // TODO: 判断输入正确
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 400,
                            child: Theme(
                              data: simpleInputDecorationTheme(context),
                              child: TextField(
                                controller: jvmArgsController,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Material(
                            color: Colors.transparent,
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
                                    globalGameConfiguration['defaultJvmArgs'] =
                                        value;
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
          initialValue: autoMemory.value,
          builder: (snapshot, updater) {
            return TitleWidgetGroup(
              "内存",
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
                      autoMemory(value);
                      globalGameConfiguration['autoMemory'] = value;
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
                                  value: maxMemory.toDouble(),
                                  min: 0,
                                  max: totalMemSize,
                                  label: maxMemory.toString(),
                                  onChanged: (value) =>
                                      maxMemory(value.toInt()),
                                  onChangeEnd: (value) {
                                    maxMemory(value.toInt());
                                    globalGameConfiguration['maxMemory'] =
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
                            maxMemory.toDouble(),
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
          "游戏",
          children: [
            ValueBuilder<bool?>(
              initialValue: globalGameConfiguration['fullScreen'] as bool,
              builder: (value, updater) => ExpansionListTile(
                isExpaned: !value!,
                tile: SwitchListTile(
                  value: value,
                  selected: !value,
                  title: const Text("全屏"),
                  onChanged: (value) => updater(value),
                ),
                expandTile: ListTile(
                  title: const Text("自定义分辨率"),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Theme(
                      data: simpleInputDecorationTheme(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 70,
                            child: resolutionTextField('width'),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("X"),
                          ),
                          SizedBox(
                            width: 70,
                            child: resolutionTextField('height'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ValueBuilder<bool?>(
              initialValue: globalGameConfiguration['log'],
              builder: (value, updater) => SwitchListTile(
                value: value!,
                title: const Text("日志"),
                onChanged: (value) {
                  updater(value);
                  globalGameConfiguration['log'] = value;
                  configController.updateConfig();
                },
              ),
            ),
            ListTile(
              title: const Text("启动参数"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 300,
                    child: Theme(
                      data: simpleInputDecorationTheme(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: textField('args'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
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
