import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

import 'game_setting.dart';

/// Game对象 存储一个游戏的信息
///
/// [path] 传入路径

class Game {
  final String path; // .minecraft/version
  late final json = jsonDecode(_convertToFile(path, "json").readAsStringSync());
  late final String jar = p.join(path, "jar");

  late String id = json['id'];
  late final String version = json['clientVersion'] ?? json['jar'];
  late final String type = json['type'];

  String? forge;
  String? fabric;
  bool? liteloader;
  String? quilt;
  String? optifine;
  bool useGlobalSetting;
  GameSetting? _setting;

  Game(this.path, {this.useGlobalSetting = false}) {
    readLibraries(json['libraries']);
  }

  GameSetting? get setting => _setting;

  String shortDescribe() {
    Map<String, String> typeName = {
      "release": "正式版",
      "snapshot": "预览版",
      "old_beta": "远古版",
    };
    return "${typeName[type]}, $version";
  }

  String longDescribe() {
    StringBuffer desc = StringBuffer(version);
    if (liteloader == true) desc.write("  LiteLoader");
    if (forge != null) desc.write("  Forge:$forge");
    if (fabric != null) desc.write("  Fabric:$fabric");
    if (quilt != null) desc.write("  Quilt:$quilt");
    if (optifine != null) desc.write("  OptiFine:$optifine");
    return desc.toString();
  }

  dynamic readFromJar(String fileName, String key) {
    final decodeZip = ZipDecoder().decodeBytes(File(jar).readAsBytesSync());
    final file = decodeZip.findFile(fileName);
    if (file == null) {
      return null;
    }
    final by = jsonDecode(utf8.decode(file.content));
    return by[key];
  }

  void readLibraries(libraries) {
    //读取是否安装Forge,高清修复等
    RegExp expForge = RegExp(
        "(net.minecraftforge:forge|net.minecraftforge:fmlloader):1.[0-9+.]+-");
    RegExp expFabric = RegExp("net.fabricmc:fabric-loader:");
    RegExp expLiteLoader = RegExp("liteloader");
    RegExp expQuilt = RegExp("org.quiltmc:quilt-loader:");
    RegExp expOptifine = RegExp("optifine:OptiFine:1.[0-9+.]+_");
    libraries.forEach((e) {
      String str = e.toString();
      if (expLiteLoader.hasMatch(str)) liteloader = true;
      if (expForge.hasMatch(str)) {
        forge = e["name"].toString().replaceAll(expForge, '');
      }
      if (expFabric.hasMatch(str)) {
        fabric = e["name"].toString().replaceAll(expFabric, '');
      }
      if (expQuilt.hasMatch(str)) {
        quilt = e["name"].toString().replaceAll(expQuilt, '');
      }
      if (expOptifine.hasMatch(str)) {
        optifine = e["name"].toString().replaceAll(expOptifine, '');
      }
    });
  }

  void readConfig() async {
    final file = File(p.join(path, 'iclversion.json'));

    if (!file.existsSync()) {
      final jsonString = const JsonEncoder.withIndent('  ')
          .convert(setting)
          .replaceAll('null', '""');
      await file.writeAsString(jsonString);
    }

    print(await file.readAsString());
  }

  factory Game.fromJson(Map<String, dynamic> json) => Game(json['path']);

  Map<String, dynamic> toJson() => {
        'useGlobalSetting': useGlobalSetting,
        'setting': _setting!.toJson(),
      };

  @override
  String toString() {
    return shortDescribe() + longDescribe();
  }
}

class Games {
  /// GameManaging.installedGames[下标].[变量]
  /// 以获取相应下标的对象的变量值
  /// [path] 版本文件夹路径
  ///
  /// [jar] jar文件路径
  ///
  /// [id] 游戏名
  ///
  /// [version] 游戏版本
  ///
  /// [Forge] Forge版本
  ///
  /// [OptiFine] OptiFine版本
  ///
  /// Examples:
  /// ```dart
  /// GameManaging.installedGames.forEach( //遍历此数组当中的对象
  ///   (element) => print(element.path), //打印遍历到的对象的path
  ///     );
  ///
  /// ```
  static List<Game> installedGames = []; //以对象存储已安装的游戏

  static final List<Map<String, dynamic>> constGameDirs = [
    //固有.minecraft目录
    {"name": "启动器下游戏目录", "Directory": Directory('.minecraft')},
    {
      "name": "官方启动器游戏目录",
      "Directory": Directory(p.join('%appdata%', 'Roadming', '.minecraft'))
    },
  ];

  static List<Map<String, dynamic>> additionGameDir = [
    //额外.minecraft目录，可添加可删除
    {
      "name": "",
      "Directory": Directory(
        p.join('D:', '游戏', 'Minecraft', '1.8', '.minecraft'),
      ),
    },
    {
      "name": "",
      "Directory": Directory(p.join('F:', 'mc', 'main', '.minecraft')),
    },
  ];

  static void addDir(String dir, String? name) {
    additionGameDir.add({"name": name, "Directory": Directory(dir)});
  }

  static Future<void> init() async {
    installedGames.clear();

    Future<void> searchGame(Directory dir) async {
      //搜索versions文件夹下的文件夹
      if (await dir.exists()) {
        dir.listSync().whereType<Directory>().forEach(
              (e) => installedGames.add(Game(e.path)),
            );
      }
    }

    //遍历游戏搜索.minecraft目录
    for (Map map in constGameDirs) {
      searchGame(Directory(p.join(map['Directory'].path, 'versions')));
    }
    for (Map map in additionGameDir) {
      searchGame(Directory(p.join(map['Directory'].path, 'versions')));
    }
  }
}

File _convertToFile(String path, String type) {
  //当系统为Windows时转换斜杠，防止无法获取当前文件夹名
  return File(p.join(path, '${path.split(Platform.pathSeparator).last}.json'));
}
