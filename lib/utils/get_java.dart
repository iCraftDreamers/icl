import 'dart:io';

void main() async {
  GetJava.init();
}

class GetJava {
  static List paths = [];
  static List versions = [];
  static Map javas = {};

  static init() async {
    paths = await onEnvironment();
    versions = version();
    javas = toMap();
  }

  static Future<List> onEnvironment() async {
    var result = <String>[];
    final command = Platform.isWindows ? "where" : "which";
    var args = Platform.isWindows ? ["\$PATH:java"] : ["-a", "\$PATH", "java"];
    final variables = ["JAVA_HOME", "JRE_HOME"];
    final processResult = await Process.run(command, args, runInShell: true);
    result = processResult.stdout.trim().split("\r\n");

    await Future.forEach(variables, (element) async {
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

  static List version() {
    return paths.map((e) {
      final regExp = RegExp(r'\\bin\\java\.exe$');
      final javaPath = e.replaceAll(regExp, '');
      final releaseFile = File('$javaPath/release');

      if (!releaseFile.existsSync()) {
        return "Unknown";
      }

      final versionLine = releaseFile
          .readAsLinesSync()
          .firstWhere((line) => line.startsWith('JAVA_VERSION='));
      return versionLine.substring('JAVA_VERSION='.length);
    }).toList();
  }

  static Map toMap() {
    return Map.fromIterables(paths, versions);
  }
}

class Java {
  final String path;
  final String version;

  const Java(this.path, this.version);
  get() {
    return Map.fromIterables(["Path", "Version"], [path, version]);
  }
}
