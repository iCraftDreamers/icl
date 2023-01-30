import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/routes/home.dart';
import '/routes/appearance.dart';
import '/routes/setting.dart';
import '/widgets/button.dart';
import '/widgets/route_builder.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget navigationBar() {
      List<Widget> children = [];
      //
      // 生成按钮
      //
      void init() {
        const Map<String, List<IconData>> items = {
          "开始": [Icons.home, Icons.home_outlined],
          "外观": [Icons.palette, Icons.palette_outlined],
          "设置": [Icons.settings, Icons.settings_outlined],
        };
        int index = 0;

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
      }

      init();

      return Container(
        width: 200,
        color: Theme.of(context).navigationBarTheme.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(children: children),
      );
    }

    // ----------------RightSize----------------
    Widget navigationView() {
      return Expanded(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Navigator(
            key: Get.nestedKey(1), // create a key by index
            initialRoute: '/home',
            onGenerateRoute: (settings) {
              switch (settings.name) {
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

    return Row(
      children: [
        navigationBar(),
        const VerticalDivider(width: 1),
        navigationView(),
      ],
    );
  }
}
