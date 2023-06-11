import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/theme.dart';
import 'package:icl/utils/game/game_setting.dart';
import 'package:icl/widgets/dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> defaultJsonData() => {
      'theme': AppTheme(),
      'globalGameConfiguration': GameSetting(),
    };

class ConfigController extends GetxController with StateMixin {
  var data = <String, dynamic>{}.obs;
  Directory? jsonPath;

  Future<String> getConfigPath() async {
    final directory = jsonPath ??= await getApplicationDocumentsDirectory();
    const fileName = "icl.json";
    return join(directory.path, fileName);
  }

  Future<void> readConfig() async {
    final file = File(await getConfigPath());
    if (!await file.exists()) {
      await createConfig();
    }
    final contents = await file.readAsString();
    final data = await json.decode(contents);
    this.data.value = data;
    print(data);
  }

  Future<void> createConfig([Map? jsonData]) async {
    final path = await getConfigPath();
    final file = File(path);
    jsonData ??= defaultJsonData();
    final data = const JsonEncoder.withIndent('  ').convert(jsonData);
    await file.writeAsString(data);
    print(await file.readAsString());
  }

  // TODO: 从此方法获取数据，并支持异常处理，自动补全json文件
  T readJson<T>(List<String> params, [dynamic json]) {
    json ??= this.data;
    late T data;
    if (params.isNotEmpty) {
      for (var p in params) {
        json = json![p];
      }
      try {
        data = json;
      } catch (e) {
        showDialog(
          context: Get.context!,
          builder: (context) => DefaultDialog(
            onlyConfirm: true,
            title: const Text(":("),
            onConfirmed: () => dialogPop(),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("我们遇到了一些错误，但我们尝试解决了"),
                Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        );
      }
    }
    return data;
  }

  void updateConfig() {
    createConfig(data);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await readConfig();
    change(data, status: RxStatus.success());
  }
}
