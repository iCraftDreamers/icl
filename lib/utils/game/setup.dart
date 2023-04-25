import 'dart:ui';

class Setup {
  bool? useGlobalSetting;
  Path? _localJavaPath;

  set setJavaPath(Path path) => _localJavaPath = path;

  Path? get localJavaPath => _localJavaPath;
}
