import 'dart:io';

void getJavaOnEnvironmentVariable() async {
  final command = Platform.isWindows ? "where java" : "which -a java";

  final arguments = <String>[];
  final process = await Process.run(command, arguments, runInShell: true);
  final exitCode = process.exitCode;
  // print(await stringToList(process.stdout));
  await stringToList(process.stdout);
  print('Exit code: $exitCode');
}

Future<List<String>?> stringToList(String string) async {
  List<String> split = string.split("\r\n");
  final process = await Process.run(
          'D:/开发环境/JDK/jdk-17.0.4/bin/java.exe', [' start '],
          runInShell: true)
      .then((ProcessResult results) => stdout.write(results.stdout));
  // print(process.stdout);
  return split;
}

void getJavaVersion(List list) {
  //
  // 获取Java版本，并将List转为Map
  //
  ProcessResult processResult;
  List<String> versions = [];
  Map<String, String> map = {};
  const arg = ["-version"];
  list.map(
    (e) async => {
      processResult = await Process.run(e, arg, runInShell: true),
    },
  );
}
