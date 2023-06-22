import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

import '/utils/game/java.dart';
import 'controller/storage.dart';
import 'interface/app.dart';

void main() async {
  init();
  runApp(const MyApp());
}

void init() {
  Get.put(ConfigController(), permanent: true);
  Javas.init();
  doWhenWindowReady(() {
    const initialSize = Size(960, 593);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
