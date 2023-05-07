import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

import '/utils/game/game.dart';
import '/utils/game/java.dart';
import '/utils/sysinfo.dart';
import 'interface/app.dart';

void main() {
  runApp(const MyApp());
  init();
}

Future<void> init() async {
  Javas.init();
  Games.init();
  Sysinfo.init();
  doWhenWindowReady(() {
    const initialSize = Size(960, 593);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
