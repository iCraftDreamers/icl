import 'java.dart';

class GameSetting {
  GameSetting({
    this.java = "auto",
    this.defaultJvmArgs = true,
    this.jvmArgs = "",
    this.autoMemory = true,
    this.maxMemory = 2048,
    this.fullScreen = false,
    this.width = 854,
    this.height = 480,
    this.log = false,
    this.args = "",
    this.serverAddress = "",
  });

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

  factory GameSetting.fromJson(Map<String, dynamic> json) => GameSetting(
        java: json['java'],
        defaultJvmArgs: json['defaultJvmArgs'],
        jvmArgs: json['jvmArgs'],
        autoMemory: json['autoMemory'],
        maxMemory: json["maxMemory"],
        fullScreen: json['fullScreen'],
        width: json['width'],
        height: json['height'],
        log: json['log'],
        serverAddress: json['serverAddress'],
      );

  Map<String, dynamic> toJson() => {
        'java': java,
        'jvmArgs': jvmArgs,
        'defaultJvmArgs': defaultJvmArgs,
        'autoMemory': autoMemory,
        'maxMemory': maxMemory,
        'fullScreen': fullScreen,
        'width': width,
        'height': height,
        'log': log,
        'args': args,
        'serverAddress': serverAddress,
      };
}
