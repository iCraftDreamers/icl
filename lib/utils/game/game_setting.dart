import 'java.dart';

class GameSetting {
  GameSetting({
    this.java,
    this.autoAllocationMemory = true,
    this.minimumMemory,
    this.maximumMemory = 2048,
    this.fullScreen = false,
    this.width = 854,
    this.height = 480,
    this.log = false,
    this.args,
    this.serverAddress,
  });

  Java? java;
  bool? autoAllocationMemory;
  int? minimumMemory;
  int? maximumMemory;
  bool? fullScreen;
  int? width;
  int? height;
  bool? log;
  String? args;
  String? serverAddress;

  factory GameSetting.fromJson(Map<String, dynamic> json) => GameSetting(
        java: Java(json['path'], versionNumber: json['version']),
        autoAllocationMemory: json['autoAllocationMemory'],
        minimumMemory: json['minimumMemory'],
        maximumMemory: json["maximumMemory"],
        fullScreen: json['fullScreen'],
        width: json['width'],
        height: json['height'],
        log: json['log'],
        serverAddress: json['serverAddress'],
      );

  Map<String, dynamic> toJson() => {
        'java': java?.toJson(),
        'autoAllocationMemory': autoAllocationMemory,
        'minimumMemory': minimumMemory,
        'maximumMemory': maximumMemory,
        'fullScreen': fullScreen,
        'width': width,
        'height': height,
        'log': log,
        'args': args,
        'serverAddress': serverAddress,
      };
}
