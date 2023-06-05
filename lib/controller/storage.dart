import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:icl/theme.dart';
import 'package:icl/utils/game/game_setting.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    jsonData ??= {
      'theme': AppTheme(),
      'globalGameSetting': GameSetting(),
    };
    final data = const JsonEncoder.withIndent('  ').convert(jsonData);
    await file.writeAsString(data);
    print(await file.readAsString());
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
