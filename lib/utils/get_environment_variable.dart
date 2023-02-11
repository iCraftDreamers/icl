import 'dart:io';

class GetJava {
  static late var paths;
  static late var versions;
  static late var javas;

  static void init() async {
    final command = Platform.isWindows ? "where java" : "which -a java";
    final processResult = await Process.run(command, [], runInShell: true);
    var versions = [];
    paths = processResult.stdout.trim().split("\r\n");

    paths.forEach(
      (e) {
        final regExp = RegExp(r'\\bin\\java\.exe$');
        final javaPath = e.replaceAll(regExp, '');

        final releaseFile = File('$javaPath/release');
        if (!releaseFile.existsSync()) {
          throw 'Java release 文件未找到';
        }

        final versionLine = releaseFile
            .readAsLinesSync()
            .firstWhere((line) => line.startsWith('JAVA_VERSION='));
        final versionString = versionLine.substring('JAVA_VERSION='.length);
        versions.add(versionString);
      },
    );

    GetJava.versions = versions;
    javas = Map.fromIterables(paths, versions);
  }
}
