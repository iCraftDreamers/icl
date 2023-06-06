import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/controller/storage.dart';

import '../theme.dart';
import 'window_bar.dart';
import 'window_surface.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigController>();

    return configController.obx(
      (data) {
        final themeData = configController.data['theme'];
        final themeMode = themeData['mode'];
        final themeModeEnum =
            EnumToString.fromString(ThemeMode.values, themeMode)!;
        final theme = AppTheme(mode: themeModeEnum);
        return GetMaterialApp(
          theme: theme.lightTheme(),
          darkTheme: theme.darkTheme(),
          themeMode: themeModeEnum,
          debugShowCheckedModeBanner: false,
          home: const Home(),
        );
      },
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
          color: Theme.of(context).colorScheme.surface,
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
