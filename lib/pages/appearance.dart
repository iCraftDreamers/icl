import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/theme.dart';

import '/widgets/page.dart';

class AppearancePage extends RoutePage {
  const AppearancePage({super.key});

  @override
  String routeName() => "外观";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [title(), const SizedBox(height: 10), body()],
    );
  }

  static var themeMode = 0.obs;

  Widget radio(e, themeMode) {
    const labes = ["跟随系统", "浅色", "深色"];

    ThemeMode? themeModeChange(index) {
      switch (index) {
        case 0:
          return ThemeMode.system;
        case 1:
          return ThemeMode.light;
        case 2:
          return ThemeMode.dark;
      }
      return null;
    }

    return Row(
      children: [
        Obx(
          () => Radio(
            value: e,
            groupValue: themeMode.value,
            onChanged: (value) => {
              themeMode(value),
              Get.changeThemeMode(themeModeChange(value)!),
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(labes[e]),
        )
      ],
    );
  }

  Widget body() {
    const radioValues = [0, 1, 2];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("主题", style: MyTheme.secondTitle),
        const SizedBox(height: 5),
        Column(
          children: radioValues.map((e) => radio(e, themeMode)).toList(),
        ),
      ],
    );
  }
}
