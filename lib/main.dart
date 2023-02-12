import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:icl/utils/games.dart';
import 'package:icl/utils/get_environment_variable.dart';

import 'components/app.dart';

void main() {
  runApp(const MyApp());
  init();
}

void init() {
  GetJava.init();
  GamesManaging.searchGames();
  doWhenWindowReady(() {
    const initialSize = Size(960, 593);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
