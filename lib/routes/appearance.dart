import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                ValueBuilder<bool?>(
                  initialValue: false,
                  builder: (value, updateFn) => CupertinoSwitch(
                    trackColor: Get.theme.highlightColor,
                    value: value!,
                    onChanged: updateFn,
                  ),
                  onUpdate: (value) => Get.changeTheme(
                    value! ? ThemeData.light() : ThemeData.dark(),
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
