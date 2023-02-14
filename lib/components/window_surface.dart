import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/theme.dart';

import '/routes/accounts.dart';
import '/routes/home.dart';
import '/routes/appearance.dart';
import '/routes/setting.dart';
import '/widgets/route_builder.dart';

class WindowSurface extends StatelessWidget {
  WindowSurface({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        navigator(context),
        const VerticalDivider(width: 1),
        navigationView(context),
      ],
    );
  }

  static var currentIndex = 1.obs;

  Widget navigationButton(int index, String text, IconData icon,
      IconData unselectIcon, BuildContext context) {
    const List<String> routeName = [
      "/account",
      "/home",
      "/appearance",
      "/setting",
    ];
    return GestureDetector(
      onTap: () {
        if (currentIndex.value != index) {
          currentIndex(index);
          Get.offAndToNamed(routeName[index], id: 1);
        }
      },
      child: Obx(
        () => Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: currentIndex.value == index
                ? Theme.of(context).colorScheme.primary
                : index == 0
                    ? Theme.of(context)
                        .extension<ShadowButtonTheme>()!
                        .background
                    : Colors.transparent,
            boxShadow: index == 0
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2), // 阴影的颜色
                      offset: Offset(0, 5), // 阴影与容器的距离
                      blurRadius: 10.0, // 高斯的标准偏差与盒子的形状卷积。
                      spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              currentIndex == index
                  ? Icon(icon, color: Colors.white)
                  : Icon(unselectIcon),
              const SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: currentIndex.value == index ? Colors.white : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigator(context) {
    const items = {
      "账号管理": [Icons.people, Icons.people_outline],
      "库": [Icons.grid_view_rounded, Icons.grid_view],
      "外观": [Icons.palette, Icons.palette_outlined],
      "设置": [Icons.settings, Icons.settings_outlined],
    };
    var index = 0;
    List<Widget> children = [];
    items.forEach(
      (key, value) => children.add(
        navigationButton(index++, key, value[0], value[1], context),
      ),
    );
    children.insert(1, const SizedBox(height: 10));
    children.insert(children.length - 1, const Spacer());

    return Container(
      width: 200,
      color: Theme.of(context).navigationBarTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(children: children),
    );
  }

  Widget navigationView(context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Navigator(
          key: Get.nestedKey(1), // create a key by index
          initialRoute: '/home',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/account':
                return createRoute(const AccountsPage());
              case '/home':
                return createRoute(const HomePage());
              case '/appearance':
                return createRoute(const AppearancePage());
              case '/setting':
                return createRoute(const SettingPage());
            }
            return null;
          },
        ),
      ),
    );
  }
}
