import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:get/get.dart';

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
  String? Forge; //Forge版本
  String? Fabric;
  String? OptiFine; //OptiFine版本

  Game(Map jsonData, String this.path, String this.jar) {
    //初始化对象
    _decodeJson(jsonData);
    _decodeLibraries(jsonData['libraries']);
  }

  void printInfo() {
    print(longDescribe());
    // print(
    // "id: $id, version: $version, type:$type, Forge:$Forge, OptiFine:$OptiFine");
  }

  String shortDescribe() {
    Map<String, String> typeName = {
      "release": "正式版",
      "snapshot": "预览版",
    };
    return "${typeName[type]}, $version";
  }

  String longDescribe() {
    StringBuffer desc = StringBuffer("$version");
    if (Forge != null) desc.write("  Forge:$Forge");
    if (Fabric != null) desc.write("  Fabric:$Fabric");
    if (OptiFine != null) desc.write("  OptiFine:$OptiFine");
    return desc.toString();
  }

  Future<void> _decodeJson(data) async {
    //解析游戏版本
    String fromJar() {
      final by = jsonDecode(utf8.decode(ZipDecoder()
          .decodeBytes(File(jar).readAsBytesSync())
          .findFile("version.json")!
          .content as List<int>));
      return by["id"];
    }

    this.id = data['id'];
    this.type = data['type'];
    this.version = data['clientVersion'] ?? data['jar'] ?? fromJar();
  }

  Future<void> _decodeLibraries(libraries) async {
    RegExp ForgeExp = RegExp(
        "(net.minecraftforge:forge|net.minecraftforge:fmlloader):1.[0-9+.]+-");
    RegExp FabricExp = RegExp("net.fabricmc:fabric-loader:");
    RegExp OptifineExp = RegExp("optifine:OptiFine:1.[0-9+.]+_");
    libraries.forEach((e) {
      String str = e.toString();
      if (ForgeExp.hasMatch(str))
        this.Forge = e["name"].toString().replaceAll(ForgeExp, '');
      if (OptifineExp.hasMatch(str))
        this.OptiFine = e["name"].toString().replaceAll(OptifineExp, '');
      if (FabricExp.hasMatch(str))
        this.OptiFine = e["name"].toString().replaceAll(FabricExp, '');
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
  static List<Directory> gameDirs = [
    //初始化游戏安装目录
    Directory('.minecraft'),
    Directory('%appdata%/Roadming/.minecraft'),
    Directory('D:/游戏/Minecraft/1.8/.minecraft'),
    Directory('F:/mc/main/.minecraft'),
  ];

  static void addDir(String dir) {
    gameDirs.add(Directory(dir));
  }

  static Future<void> init() async {
    installedGames.clear();
    File convertToFile(FileSystemEntity dir, String type) {
      //当系统为Windows时转换斜杠，防止无法获取当前文件夹名
      return File(
          '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.${type}');
    }

    Future<void> addGame(dir) async {
      var json = convertToFile(dir, "json");
      var jar = convertToFile(dir, "jar");
      if (await json.exists())
        installedGames.add(
            Game(jsonDecode(await json.readAsString()), dir.path, jar.path));
    }

    //遍历游戏安装目录下的已安装游戏文件夹
    for (Directory dir in gameDirs) {
      Directory versionDir = Directory('${dir.path}/versions');
      Future(() async => {
            if (await versionDir.exists())
              versionDir
                  .listSync()
                  .where((element) => element is Directory)
                  .forEach((element) => addGame(element))
          });
    }
  }
}
