import 'dart:io';

void getJavaEnvironmentVariable() async {
  final command = Platform.isWindows ? "where java" : "which -a java";

  final arguments = <String>[];
  final process = await Process.run(command, arguments, runInShell: true);
  final exitCode = process.exitCode;
  print(stringToList(process.stdout));
  print('Exit code: $exitCode');
}

List<String>? stringToList(String string) {
  List<String> result = [];
  var next = 0;
  var str = string;

  while (true) {
    str = str.substring(next);
    next = str.indexOf("\r\n");
    if (next == -1) break;
    result.add(str.substring(0, next));
    next += 2;
  }

  return result;
}

// void getJavaVersion() {}
