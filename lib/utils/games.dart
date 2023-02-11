import 'dart:io';
import 'dart:convert';

class GamesManaging {
  List<Map> installedGames = [];
  Future<void> searchGames() async {
    final myDir = Directory('.minecraft\\versions');
    final subDirs = myDir.listSync().where((element) => element is Directory);
    for (var dir in subDirs) {
      final jarFile = File('${dir.path}\\${dir.path.split('\\').last}.jar');
      final jsonFile = File('${dir.path}\\${dir.path.split('\\').last}.json');
      final jsonContent = jsonDecode(await jsonFile.readAsString());
      Map<String, dynamic> jsonData = jsonContent;
      installedGames.add({
        "id": jsonData['id'],
        "version": jsonData['clientVersion'],
        "Path": dir.path,
        "jarFile": jarFile.path
      });
    }
    print(installedGames);
  }
}
