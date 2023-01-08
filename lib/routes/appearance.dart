import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/themes.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemesController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("外观", style: TextStyle(fontSize: 32)),
          const SizedBox(height: 10),
          const Text("主题", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 5),
          Container(
            width: 150,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5),
              color: Get.theme.highlightColor,
            ),
            child: Row(
              children: [
                const Text("跟随系统"),
                const Spacer(),
                GetBuilder<ThemesController>(
                  builder: (controller) => CupertinoSwitch(
                    trackColor: Get.theme.highlightColor,
                    value: themeController.adaptive.value,
                    onChanged: ((value) {
                      themeController.updateState(value.obs);
                      Get.changeTheme(
                          value ? ThemeData.light() : ThemeData.dark());
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
