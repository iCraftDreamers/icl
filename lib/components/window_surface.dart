import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/theme.dart';

import '/controllers/pages.dart';
import '/routes/account.dart';
import '/routes/home.dart';
import '/routes/appearance.dart';
import '/routes/setting.dart';
import '/widgets/button.dart';
import '/widgets/route_builder.dart';

class WindowSurface extends StatelessWidget {
  const WindowSurface({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        navigationBar(context),
        const VerticalDivider(width: 1),
        navigationView(context),
      ],
    );
  }

  Widget navigationBar(context) {
    Widget accNvgButton() {
      final c = Get.put(PagesController());
      const index = -1;
      const routeName = "/account";

      return GestureDetector(
        onTap: () {
          if (c.current.value != index) {
            c.current(index);
            Get.offAndToNamed(routeName, id: 1);
          }
        },
        child: Obx(
          () => Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5),
              color: c.current.value == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .extension<AccNvgButtonTheme>()!
                      .background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15), // 阴影的颜色
                  offset: Offset(0, 5), // 阴影与容器的距离
                  blurRadius: 15.0, // 高斯的标准偏差与盒子的形状卷积。
                  spreadRadius: 5.0, // 在应用模糊之前，框应该膨胀的量。
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.people),
                const SizedBox(width: 5),
                Text(
                  "账号",
                  style: TextStyle(
                    color: c.current.value == index ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    List<Widget> children = [accNvgButton(), SizedBox(height: 10)];
    int index = 0;
    const items = {
      "开始": [Icons.home, Icons.home_outlined],
      "外观": [Icons.palette, Icons.palette_outlined],
      "设置": [Icons.settings, Icons.settings_outlined],
    };

    items.forEach(
      (key, value) => children.add(
        NavigationButton(
          lable: key,
          icon: value[0],
          unselectedIcon: value[1],
          index: index++,
        ),
      ),
    );
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
                return createRoute(const AccountPage());
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
