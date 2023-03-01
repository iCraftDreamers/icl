import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';

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
  static List<Game> installedGames = []; //以对象存储已安装的游戏
  // e.g. GameManaging.installedGames[下标].version 获取版本
  static List<Directory> gameDirs = [
    //初始化游戏安装目录
    Directory('.minecraft'),
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
    for (var dir in gameDirs) {
      //遍历游戏安装目录下的已安装游戏文件夹
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
    for (var dir in versionDirs) {
      //解析已安装游戏的目录内的json文件，并以对象存储
      installedGames.add(Game(
          jsonDecode(await convertToFile(dir, "json").readAsString()),
          dir.path,
          convertToFile(dir, "jar").path));
    }
  }
}
