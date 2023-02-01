import 'dart:io';

void getJavaOnEnvironmentVariable() async {
  final command = Platform.isWindows ? "where java" : "which -a java";
  final arguments = <String>[];
  final process = await Process.run(command, arguments, runInShell: true);
  final exitCode = process.exitCode;
  print(await stringToList(process.stdout));
  print('Exit code: $exitCode');
}

Future<Map<String, String>> stringToList(String string) async {
  List<String> path = string.trim().split("\r\n");
  List<String> versions = [];
  ProcessResult process;

  await Future.forEach(
    path,
    (e) async {
      process = await Process.run(
        e.replaceFirst('java', 'javac', e.lastIndexOf('java')),
        ['-version'],
        runInShell: true,
      );
      versions.add(
        (process.stdout == "" ? process.stderr : process.stdout).substring(6),
      );
    },
  );

  return Map.fromIterables(versions, path);
}
