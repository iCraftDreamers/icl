import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;

import 'game_setting.dart';

part 'game.g.dart';

/// Game对象 存储一个游戏的信息
///
/// [path] 传入路径
@JsonSerializable()
class Game {
  final String path; // .minecraft/version/xxx

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? forge;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? fabric;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? liteloader;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? quilt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? optifine;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late var jsonData =
      jsonDecode(File("${p.basename(path)}.json").readAsStringSync());
  @JsonKey(includeFromJson: false, includeToJson: false)
  late var jar = jsonData['jar'];
  @JsonKey(includeFromJson: false, includeToJson: false)
  late var id = jsonData['id'];
  @JsonKey(includeFromJson: false, includeToJson: false)
  late var version = jsonData['clientVersion'];
  @JsonKey(includeFromJson: false, includeToJson: false)
  late var type = jsonData['type'];

  bool useGlobalSetting;
  GameSetting? setting;

  Game(
    this.path, {
    this.useGlobalSetting = true,
    this.setting,
  }) {
    readLibraries();
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

  void readLibraries() {
    List<Map<String, dynamic>> librariesJsonData = jsonData['libraries'];
    for (var e in librariesJsonData) {
      var name = e['name'];
      if (name.startsWith('net.minecraftforge')) {
        forge = name.split(':')[2];
      }
    }
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @override
  String toString() {
    return 'Version: $version';
  }
}

@JsonSerializable()
class Path {
  @JsonKey(includeFromJson: false, includeToJson: false)
  static final _availableGames = <Game>[];
  final String? name;
  final String? path;
  static List<Map<String, String>> paths = [
    _template("启动器目录", p.join(Platform.script.path, '.minecraft')),
    _template("官方启动器目录", p.join('%appdata%', 'Roadming', '.minecraft')),
  ];

  Path({this.name, this.path});

  static List<Game> get availableGames => _availableGames;

  static void addAvailableGame(Game game) => _availableGames.add(game);

  static bool addPath(String name, String path) {
    if (Directory(path).existsSync()) {
      paths.add(_template(name, path));
      return true;
    }
    return false;
  }

  static Map<String, String> _template(String name, String path) {
    return {'name': name, 'path': path};
  }

  Future<void> search() async {
    _availableGames.clear();
    for (var path in paths) {
      var stream = Directory(path['path']!).list(followLinks: false);
      await for (var e in stream) {
        if (e is Directory &&
            await Directory(p.join(e.path, "${p.basename(e.path)}.json"))
                .exists()) {
          addAvailableGame(Game(e.path));
        }
      }
    }
  }

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);

  Map<String, dynamic> toJson() => _$PathToJson(this);

  // static List<Map<String, dynamic>> toJsonList(List<Path>? paths) {
  //   return paths == null ? [
  //   _template("启动器目录", p.join(Platform.script.path, '.minecraft')),
  //   _template("官方启动器目录", p.join('%appdata%', 'Roadming', '.minecraft')),
  // ] : paths.map((path) => path.toJson()).toList();
  // }

  // static String toJsonString(List<Path> paths) {
  //   return jsonEncode(toJsonList(paths));
  // }
}
