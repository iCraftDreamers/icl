import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/themes.dart';

import '/widgets/page.dart';

class AppearancePage extends BasePage with BasicPage {
  const AppearancePage({super.key});

  @override
  String pageName() => "外观";

  Widget body(context) {
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

    Widget toggleButton(IconData i, lable) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [Icon(i), const SizedBox(width: 5), Text(lable)],
        ),
      );
    }

    Get.put(ThemesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("主题", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Theme.of(context).highlightColor,
          ),
          child: Row(
            children: [
              const Text("颜色"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GetBuilder<ThemesController>(
                  builder: (c) => ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(7.5)),
                    isSelected: c.isSelected,
                    onPressed: (index) => {
                      c.updateIsSelected(index),
                      Get.changeThemeMode(themeModeChange(index)!),
                    },
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text("跟随系统"),
                      ),
                      toggleButton(Icons.light_mode, "浅色"),
                      toggleButton(Icons.nights_stay, "深色"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [head(), body(context)],
    );
  }
}
