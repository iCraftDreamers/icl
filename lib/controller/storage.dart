import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:icl/theme.dart';
import 'package:icl/utils/game/game_setting.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConfigController extends GetxController with StateMixin {
  var jsonData = <String, dynamic>{};
  Directory? _jsonPath;

  Map<String, dynamic> defaultJsonData({
    AppTheme? appTheme,
    GameSetting? gameSetting,
    Map<String, dynamic>? jsonData,
  }) {
    return {
      'theme': appTheme ??
          (jsonData == null
              ? AppTheme()
              : AppTheme.fromJson(jsonData['theme'])),
      'globalSettings': gameSetting ??
          (jsonData == null
              ? GameSetting()
              : GameSetting.fromJson(jsonData['globalSettings'])),
    };
  }

  Future<Directory> get jsonPath async {
    // 使用一个私有的变量来缓存结果
    _jsonPath ??= await getApplicationDocumentsDirectory();
    return _jsonPath!;
  }

  Future<String> getConfigPath() async {
    final directory = await jsonPath;
    const fileName = "icl.json";
    return join(directory.path, fileName);
  }

  Future<void> readConfig() async {
    final file = File(await getConfigPath());
    if (!await file.exists()) {
      await createConfig();
    }
    final contents = await file.readAsString();
    jsonData = json.decode(
        json.encode(defaultJsonData(jsonData: await json.decode(contents))));
  }

  Future<void> createConfig([Map? jsonData]) async {
    final path = await getConfigPath();
    final file = File(path);
    jsonData ??= defaultJsonData();
    final data = const JsonEncoder.withIndent('  ').convert(jsonData);
    await file.writeAsString(data);
  }

  void updateConfig([List<String>? tag]) {
    createConfig(jsonData);
    update(tag);
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await readConfig();
    change(jsonData, status: RxStatus.success());
  }
}
