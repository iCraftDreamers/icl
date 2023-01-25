import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/themes.dart';

import '/widgets/page.dart';

class AppearancePage extends BasePage with BasicPage {
  const AppearancePage({super.key});

  @override
  String pageName() => "外观";

  Widget radio(e, c) {
    const labes = ["跟随系统", "浅色", "深色"];
    ThemeMode? themeModeChange(index) {
      switch (index) {
        case 1:
          return ThemeMode.system;
        case 2:
          return ThemeMode.light;
        case 3:
          return ThemeMode.dark;
      }
      return null;
    }

    return Row(
      children: [
        Radio(
          value: e,
          groupValue: c.thememode.value,
          onChanged: (value) => {
            Get.changeThemeMode(themeModeChange(value)!),
            c.updateThemeMode(value!),
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(labes[e - 1]),
        )
      ],
    );
  }

  Widget body() {
    Get.put(ThemesController());
    const radioValues = [1, 2, 3];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("主题", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 5),
          GetBuilder<ThemesController>(
            builder: (c) => Column(
              children: radioValues.map((e) => radio(e, c)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [head(), body()],
    );
  }
}
