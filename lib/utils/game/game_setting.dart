import 'package:json_annotation/json_annotation.dart';

part 'game_setting.g.dart';

@JsonSerializable()
class GameSetting {
  GameSetting({
    this.java,
    this.defaultJvmArgs,
    this.jvmArgs,
    this.autoMemory,
    this.maxMemory,
    this.fullScreen,
    this.width,
    this.height,
    this.log,
    this.args,
    this.serverAddress,
  }) {
    java ??= "auto";
    defaultJvmArgs ??= true;
    jvmArgs ??= "";
    autoMemory ??= true;
    maxMemory ??= 2048;
    fullScreen ??= false;
    width ??= 854;
    height ??= 480;
    log ??= false;
    args ??= "";
    serverAddress ??= "";
  }

  String? java;
  bool? defaultJvmArgs;
  String? jvmArgs;
  bool? autoMemory;
  int? maxMemory;
  bool? fullScreen;
  int? width;
  int? height;
  bool? log;
  String? args;
  String? serverAddress;

  factory GameSetting.fromJson(Map<String, dynamic> json) =>
      _$GameSettingFromJson(json);

  Map<String, dynamic> toJson() => _$GameSettingToJson(this);
}
