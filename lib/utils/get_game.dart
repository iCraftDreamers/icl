import 'dart:io';
import 'dart:convert';

class Game {
  late final jsonData;
  late final String path;
  late final String jar;
  late final String id;
  late final String version;
  late final String? Forge;
  late final String? OptiFine;

  Game(this.jsonData, this.path, this.jar) {
    id = decodeID();
    version = decodeVersion();
  }

  String decodeID() {
    return jsonData['id'];
  }

  String decodeVersion() {
    return jsonData['clientVersion'] ?? jsonData['jar'];
  }
}

class GameManaging {
  static List<Game> installedGames = [];
  static List<Directory> gameDirs = [
    Directory('.minecraft'),
    Directory('%appdata%/Roadming/.minecraft')
  ];

  static void addDir(String dir) {
    gameDirs.add(Directory(dir));
  }

  static File convertToFile(FileSystemEntity dir, String type) {
    return File(
        '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.${type}');
  }

  static Future<void> init() async {
    installedGames.clear();
    List<FileSystemEntity> versionDirs = [];
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
    for (var dir in versionDirs) {
      // final jarFile = convertToFile(dir, "jar");
      // final jsonFile = convertToFile(dir, "json");
      // final jsonContent = jsonDecode(await jsonFile.readAsString());
      // Map<String, dynamic> jsonData = jsonContent;
      installedGames.add(Game(
          jsonDecode(await convertToFile(dir, "json").readAsString()),
          dir.path,
          convertToFile(dir, "jar").path));
    }
  }
}
