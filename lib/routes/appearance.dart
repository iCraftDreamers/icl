import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/page.dart';

class AppearancePage extends BasePage with BasicPage {
  const AppearancePage({super.key});

  @override
  String pageName() => "外观";

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
        Radio(
          value: e,
          groupValue: themeMode.value,
          onChanged: (value) => {
            themeMode(value),
            Get.changeThemeMode(themeModeChange(value)!),
          },
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
    var themeMode = 0.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("主题", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Obx(
          () => Column(
            children: radioValues.map((e) => radio(e, themeMode)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [head(), const SizedBox(height: 10), body()],
    );
  }
}
