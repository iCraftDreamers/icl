import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';

/// Game对象 存储一个游戏的信息
///
/// [jsonData]传入解析好的json数据
///
/// [path]传入路径
///
/// [jar]传入jar文件路径

class Game {
  late final String path; //版本文件夹路径
  late final String jar; //jar文件路径
  late final String id; //游戏名
  late final String version; //游戏版本
  late final String type;
  String? forge; //Forge版本
  String? fabric;
  bool? liteloader;
  String? quilt;
  String? optifine; //OptiFine版本

  Game(Map jsonData, this.path, this.jar) {
    //初始化对象,并读取该版本的信息
    _readInfo(jsonData);
    _readLibraries(jsonData['libraries']);
  }

  @override
  String toString() {
    return shortDescribe() + longDescribe();
  }

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

  Future<void> _readInfo(data) async {
    //读取版本，发布类型与版本号

    String fromJar() {
      final by = jsonDecode(utf8.decode(ZipDecoder()
          .decodeBytes(File(jar).readAsBytesSync())
          .findFile("version.json")!
          .content as List<int>));
      return by["id"];
    }

    id = data['id'];
    type = data['type'];
    version = data['clientVersion'] ?? data['jar'] ?? fromJar();
  }

  Future<void> _readLibraries(libraries) async {
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
}

class GameManaging {
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
      "Directory": Directory('%appdata%/Roadming/.minecraft')
    },
  ];

  static List<Map<String, dynamic>> additionGameDir = [
    //额外.minecraft目录，可添加可删除
    {"name": "", "Directory": Directory('D:/游戏/Minecraft/1.8/.minecraft')},
    {"name": "", "Directory": Directory('F:/mc/main/.minecraft')},
  ];

  static void addDir(String dir, String? name) {
    additionGameDir.add({"name": name, "Directory": Directory(dir)});
  }

  static Future<void> init() async {
    installedGames.clear();

    File convertToFile(FileSystemEntity dir, String type) {
      //当系统为Windows时转换斜杠，防止无法获取当前文件夹名
      return File(
          '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.$type');
    }

    Future<void> searchGame(Directory dir) async {
      //搜索versions文件夹下的文件夹
      if (await dir.exists()) {
        dir.listSync().whereType<Directory>().forEach((e) => Future(() async {
              File json = convertToFile(e, "json");
              File jar = convertToFile(e, "jar");
              //判断是否为合法的已安装版本目录
              if (await json.exists()) {
                installedGames.add(Game(
                    jsonDecode(await json.readAsString()), dir.path, jar.path));
              }
            }));
      }
    }

    //遍历游戏搜索.minecraft目录
    for (Map map in constGameDirs) {
      searchGame(Directory('${map["Directory"].path}/versions'));
    }
    for (Map map in additionGameDir) {
      searchGame(Directory('${map["Directory"].path}/versions'));
    }
  }
}
