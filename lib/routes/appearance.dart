import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/themes.dart';

import '../widgets/page.dart';

class AppearancePage extends BasePage with BasicPage {
  const AppearancePage({super.key});

  @override
  String pageName() => "外观";

  @override
  List<Widget> get body => [
        const Text("主题", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Get.theme.highlightColor,
          ),
          child: Row(
            children: [
              const Text("深色模式"),
              const Spacer(),
              ValueBuilder<bool?>(
                initialValue: Get.isDarkMode,
                builder: (value, updateFn) => CupertinoSwitch(
                  trackColor: Get.theme.highlightColor,
                  value: value!,
                  onChanged: updateFn,
                ),
                onUpdate: (value) {
                  Get.changeTheme(
                    value! ? ThemeData.dark() : ThemeData.light(),
                  );
                },
              ),
            ],
          ),
        ),
      ];
}
