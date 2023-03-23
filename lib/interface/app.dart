import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/theme.dart';
import 'window_bar.dart';
import 'window_surface.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Home(),
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
        child: Column(
          children: const [
            WindowTitleBar(
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("iCraft Launcher"),
                ),
              ),
            ),
            Divider(height: 1),
            Expanded(child: WindowSurface()),
          ],
        ),
      ),
    );
  }
}
