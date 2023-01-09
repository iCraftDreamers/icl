import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

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
          children: [
            const WindowsBar(),
            Divider(
              color: Get.theme.cardColor,
              height: 1,
            ),
            const Expanded(child: MyHomePage()),
          ],
        ),
      );
    }

    return GetMaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}
