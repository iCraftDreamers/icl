import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;

import 'game.dart';

part 'path.g.dart';

@JsonSerializable()
class GamePath {
  GamePath({this.name = "", this.path = ""});

  final String name;
  final String path;

  static final _availableGames = <Game>[];
  static final _paths = [
    GamePath(
      name: "启动器目录",
      path: p.join(File(Platform.resolvedExecutable).parent.path, '.minecraft'),
    ),
    // TODO: Linux & Macos 官方启动器目录
    GamePath(
      name: "官方启动器目录",
      path: p.join(
          Platform.environment['APPDATA'] ??
              "C:\\Users\\${Platform.environment['USERNAME']}\\AppData",
          'Roadming',
          '.minecraft'),
    ),
  ].obs;

  static List<Game> get availableGames => _availableGames;
  static void addAvailableGame(Game game) => _availableGames.add(game);
  static List<GamePath> get paths => _paths.value;

  static bool addPath(String name, String path) {
    if (Directory(path).existsSync()) {
      paths.add(GamePath.fromJson({name: name, path: path}));
      return true;
    }
    return false;
  }

  static Future<void> search() async {
    _availableGames.clear();
    for (final path in paths) {
      var stream = Directory(path.path).list(followLinks: false);
      try {
        await for (var e in stream) {
          if (e is Directory &&
              await Directory(p.join(e.path, "${p.basename(e.path)}.json"))
                  .exists()) {
            addAvailableGame(Game(e.path));
          }
        }
      } catch (e) {
        e.printError();
      }
    }
  }

  factory GamePath.fromJson(Map<String, dynamic> json) =>
      _$GamePathFromJson(json);
  Map<String, dynamic> toJson() => _$GamePathToJson(this);

  static List<Map<String, dynamic>> toJsonList() {
    return json.decode(json.encode(paths));
  }

  static List<GamePath> fromJsonList(List<dynamic>? paths) {
    if (paths != null) {
      _paths.value = paths.map((path) => GamePath.fromJson(path)).toList();
    }
    return _paths;
  }
}
