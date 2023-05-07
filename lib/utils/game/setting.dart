import 'java.dart';

class Setting {
  Java? java;
  String? arguments;
  double? minimumMemory;
  double? maximumMemory;
  bool? fullScreen;
  int? width;
  int? height;
  bool? log;
  String? serverAddress;

  Setting({
    this.java,
    this.arguments,
    this.minimumMemory,
    this.maximumMemory,
    this.fullScreen,
    this.width,
    this.height,
    this.log,
    this.serverAddress,
  });
}

final globalSetting = Setting(
  java: Javas.list[0],
);
