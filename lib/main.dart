import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

import 'widgets/theme.dart';
import 'components/window_surface.dart';
import 'components/window_bar.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(960, 593);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return Scaffold(
        body: Column(
          children: const [
            WindowBar(),
            Divider(height: 1),
            Expanded(child: MyHomePage()),
          ],
        ),
      );
    }

    return GetMaterialApp(
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}
