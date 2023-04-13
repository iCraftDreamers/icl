import 'dart:io';

class Java {
  late final String? path;
  late final String? version;

  Java([this.path, version]) {
    this.version = version ?? getVersion();
  }

  String getVersion() {
    final regExp = RegExp(r'\\bin\\java\.exe$');
    final javaPath = path?.replaceAll(regExp, '');
    final releaseFile = File('$javaPath/release');

    if (!releaseFile.existsSync()) {
      return "Unknown";
    }

    final versionLine = releaseFile
        .readAsLinesSync()
        .firstWhere((line) => line.startsWith('JAVA_VERSION='));
    return versionLine.substring('JAVA_VERSION='.length);
  }

  @override
  String toString() {
    return Map.fromIterables(["Path", "Version"], [path, version]).toString();
  }
}

class GetJava {
  static List<Java> list = [];

  static Future<void> init() async {
    list.clear();
    pathOnEnvironment()
        .then((paths) => {for (final path in paths) list.add(path)});
  }

  static Future<List> pathOnEnvironment() async {
    var result = <String>[];
    final command = Platform.isWindows ? "where" : "which";
    var args = Platform.isWindows ? ["\$PATH:java"] : ["-a", "\$PATH", "java"];
    final variables = ["JAVA_HOME", "JRE_HOME"];
    final processResult = await Process.run(command, args, runInShell: true);
    result = processResult.stdout.trim().split("\r\n");

    Future.forEach(variables, (element) async {
      final variable = Platform.environment[element];
      if (variable == null) return;
      final path = variable + (Platform.isWindows ? "\\bin" : "/bin");
      if (result.contains(
          path.trim() + (Platform.isWindows ? "\\java.exe" : "java"))) {
        return;
      }

      args = Platform.isWindows ? ['/R', path, "java"] : [element, "java"];
      final processResult = await Process.run(command, args, runInShell: true);
      if (processResult.stdout == "") return;
      result.add(processResult.stdout.trim());
    });
    return result;
  }
}
