import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'window_bar.dart';
import 'window_surface.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MyTheme.lightTheme(),
      darkTheme: MyTheme.darkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: const Column(
          children: [
            WindowTitleBar(),
            Divider(height: 1),
            Expanded(child: WindowSurface()),
          ],
        ),
      ),
    );
  }
}
