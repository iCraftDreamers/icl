import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:icl/utils/get_game.dart';
import 'package:icl/utils/get_java.dart';
import 'package:icl/utils/sysinfo.dart';

import 'interface/app.dart';

void main() {
  runApp(const MyApp());
  init();
}

void init() async {
  GetJava.init();
  GameManaging.init();
  Sysinfo.init();
  doWhenWindowReady(() {
    const initialSize = Size(960, 593);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
