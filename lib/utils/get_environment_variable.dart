import 'dart:io';

class GetJava {
  static late var paths;
  static late var versions;
  static late var javas;

  static void init() async {
    // 在环境变量获取Java路径
    final command = Platform.isWindows ? "where java" : "which -a java";
    final processResult = await Process.run(command, [], runInShell: true);

    paths = processResult.stdout.trim().split("\r\n");

    final java_home = Platform.environment['JAVA_HOME'];
    final jre_home = Platform.environment['JRE_HOME'];
    if (paths.contains(java_home)) {
      paths.add(java_home! +
          (Platform.isWindows ? "\\bin\\java.exe" : "/bin/java.exe"));
    }
    if (paths.contains(jre_home)) {
      paths.add(jre_home! +
          (Platform.isWindows ? "\\bin\\java.exe" : "/bin/java.exe"));
    }

    // 获取Java版本
    versions = [];
    paths.forEach(
      (e) {
        final regExp = RegExp(r'\\bin\\java\.exe$');
        final javaPath = e.replaceAll(regExp, '');
        final releaseFile = File('$javaPath/release');

        if (!releaseFile.existsSync()) {
          throw 'Java release 文件未找到，路径 $javaPath';
        }

        final versionLine = releaseFile
            .readAsLinesSync()
            .firstWhere((line) => line.startsWith('JAVA_VERSION='));
        final versionString = versionLine.substring('JAVA_VERSION='.length);
        versions.add(versionString);
      },
    );
    // 生成Map
    javas = Map.fromIterables(paths, versions);
  }
}
