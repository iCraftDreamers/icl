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
  late final jsonData;
  late final String path; //版本文件夹路径
  late final String jar; //jar文件路径
  late final String id; //游戏名
  late final String version; //游戏版本
  late final String? Forge; //Forge版本
  late final String? OptiFine; //OptiFine版本

  Game(this.jsonData, this.path, this.jar) {
    //初始化对象
    id = decodeID();
    version = decodeVersion();
  }

  String decodeID() {
    //解析游戏id
    return jsonData['id'];
  }

  String decodeVersion() {
    //解析游戏版本
    String fromJar() {
      final by = jsonDecode(utf8.decode(ZipDecoder()
          .decodeBytes(File(jar).readAsBytesSync())
          .findFile("version.json")!
          .content as List<int>));

      return by["id"];
    }

    return jsonData['clientVersion'] ?? jsonData['jar'] ?? fromJar();
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
    Directory('D:/游戏/Minecraft/1.8/.minecraft'),
    Directory('%appdata%/Roadming/.minecraft')
  ];

  static void addDir(String dir) {
    gameDirs.add(Directory(dir));
  }

  static File convertToFile(FileSystemEntity dir, String type) {
    //当系统为Windows时转换斜杠，防止无法获取当前文件夹名
    return File(
        '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.${type}');
  }

  static Future<void> init() async {
    installedGames.clear();
    List<FileSystemEntity> versionDirs = [];
    //遍历游戏安装目录下的已安装游戏文件夹
    for (var dir in gameDirs) {
      var versionDir = Directory('${dir.path}/${'versions'}');
      if (await versionDir.exists()) {
        versionDirs.addAll(
          versionDir
              .listSync()
              .where((element) => element is Directory)
              .toList(),
        );
      }
    }
    //解析已安装游戏的目录内的json文件，并以对象存储
    for (var dir in versionDirs) {
      installedGames.add(Game(
          jsonDecode(await convertToFile(dir, "json").readAsString()),
          dir.path,
          convertToFile(dir, "jar").path));
    }
  }
}
