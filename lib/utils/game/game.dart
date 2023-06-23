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
