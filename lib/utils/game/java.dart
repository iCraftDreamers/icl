import 'dart:io';

class Java {
  final String path;
  late final String versionNumber;

  Java(this.path, {versionNumber}) {
    this.versionNumber = versionNumber ?? Javas.getVersion(path);
  }

  String get version {
    final regex1 = RegExp(r"(\d+)");
    final regex2 = RegExp(r"\.(\d+)");
    final match1 = regex1.firstMatch(versionNumber);
    final match2 = regex2.firstMatch(versionNumber);
    if (match1 != null) {
      if (match1.group(1) == "1" && match2 != null) {
        return "${match2.group(1)}";
      } else {
        return "${match1.group(1)}";
      }
    } else {
      return "unknown";
    }
  }

  @override
  String toString() {
    return "Path: $path, VersionNumber: $versionNumber, Version: $version";
  }
}

abstract class Javas {
  static List<Java> list = [];

  static Future<void> init() async {
    list.clear();
    pathOnEnvironment()
        .then((paths) => {for (final path in paths) list.add(Java(path))});
  }

  // static Java autoSelect(String version) {}

  static String getVersion(String path) {
    final regExp = RegExp(r'\\bin\\java\.exe$');
    final javaPath = path.replaceAll(regExp, '');
    final releaseFile = File('$javaPath/release');

    if (!releaseFile.existsSync()) {
      return "Unknown";
    }

    final versionLine = releaseFile
        .readAsLinesSync()
        .firstWhere((line) => line.startsWith('JAVA_VERSION='));
    return versionLine.substring('JAVA_VERSION='.length);
  }

  static Future<List<String>> pathOnEnvironment() async {
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
