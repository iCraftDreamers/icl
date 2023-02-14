import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/theme.dart';
import 'window_bar.dart';
import 'window_surface.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget home() {
      return Scaffold(
        body: Column(
          children: [
            const WindowBar(),
            const Divider(height: 1),
            Expanded(child: WindowSurface()),
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
