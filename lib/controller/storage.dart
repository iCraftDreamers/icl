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
      'globalGameConfiguration': gameSetting ??
          (jsonData == null
              ? GameSetting()
              : GameSetting.fromJson(jsonData['globalGameConfiguration'])),
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
      createConfig();
    }
    final contents = await file.readAsString();
    jsonData = json.decode(
        json.encode(defaultJsonData(jsonData: await json.decode(contents))));
  }

  void createConfig([Map? jsonData]) async {
    final path = await getConfigPath();
    final file = File(path);
    jsonData ??= defaultJsonData();
    final data = const JsonEncoder.withIndent('  ').convert(jsonData);
    await file.writeAsString(data);
  }

  // TODO: 从此方法获取数据，并支持异常处理，自动补全json文件
  // T readJson<T>(List<String> params) {
  //   dynamic data = jsonData;
  //   if (params.isEmpty) {
  //     return data as T;
  //   }
  //   try {
  //     for (final param in params) {
  //       if (data is List) {
  //         data = data[(int.parse(param))];
  //       } else if (data is Map) {
  //         data = data.putIfAbsent(
  //             param, () => throw Exception('Invalid key: $param'));
  //       } else {
  //         throw Exception('Invalid JSON data: $data');
  //       }
  //     }
  //     print(data.runtimeType);
  //     return data as T;
  //   } catch (e) {
  //     // 如果发生异常，尝试修复json文件
  //     print('Error: $e');
  //     if (data != null) updateJson(params, null);
  //     final newJsonData = defaultJsonData(
  //       gameSetting: GameSetting.fromJson(jsonData['globalGameConfiguration']),
  //       appTheme: AppTheme.fromJson(jsonData['theme']),
  //     );
  //     createConfig(newJsonData);
  //     jsonData = json.decode(json.encoder.convert(newJsonData));
  //   }
  //   return readJson<T>(params);
  // }

  // void updateJson(List<String> params, newData) {
  //   var jsonData = this.jsonData;
  //   try {
  //     var last = params.length - 1;
  //     for (var i = 0; i < last; i++) {
  //       jsonData = jsonData[params[i]];
  //     }
  //     jsonData[params[last]] = newData;
  //   } catch (e) {
  //     print("SLM");
  //   }
  // }

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
