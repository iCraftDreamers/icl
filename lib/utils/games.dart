import 'dart:io';
import 'dart:convert';

class GamesManaging {
  static List<Map> installedGames = [];
  static List<Directory> gameDirs = [
    Directory('.minecraft'),
    Directory('%appdata%/Roadming/.minecraft')
  ];

  static void addGameDirs(String dir) {
    gameDirs.add(Directory(dir));
  }

  static File convertToFile(FileSystemEntity dir, String type) {
    return File(
        '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.${type}');
  }

  static Future<void> searchGames() async {
    installedGames.clear();
    List<FileSystemEntity> versionDirs = [];
    for (var dir in gameDirs) {
      var versionDir = Directory('${dir.path}/${'versions'}');
      if (await versionDir.exists()) {
        versionDirs.addAll(versionDir
            .listSync()
            .where((element) => element is Directory)
            .toList());
      }
    }
    for (var dir in versionDirs) {
      final jarFile = convertToFile(dir, "jar");
      final jsonFile = convertToFile(dir, "json");
      final jsonContent = jsonDecode(await jsonFile.readAsString());
      Map<String, dynamic> jsonData = jsonContent;
      installedGames.add({
        "id": jsonData['id'],
        "version": jsonData['clientVersion'],
        "Path": dir.path,
        "jarFile": jarFile.path
      });
    }
  }
}
