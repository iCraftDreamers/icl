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
      const Map<String, IconData> items = {
        "开始": Icons.home,
        "外观": Icons.palette,
        "设置": Icons.settings
      };
      int index = 0;
      List<Widget> children = [];
      items.forEach((key, value) => children
          .add(MyNavigationBar(lable: key, icon: value, index: index++)));
      children.insert(children.length - 1, const Spacer());

      return Container(
        width: 200,
        color: Theme.of(context).appBarTheme.backgroundColor,
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
