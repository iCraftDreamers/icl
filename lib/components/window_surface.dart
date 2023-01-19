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
        "主页": Icons.home,
        "外观": Icons.palette,
        "设置": Icons.settings
      };
      int index = 0;
      List<Widget> children = <Widget>[];
      items.forEach((key, value) {
        if (index == items.length - 1) children.add(const Spacer());
        children.add(NavigationButton(lable: key, icon: value, index: index++));
      });

      return Container(
        width: 200,
        color: Theme.of(context).appBarTheme.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: children,
        ),
      );
    }

    // ----------------RightSize----------------
    Widget navigationView() {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
      children: [navigationBar(), navigationView()],
    );
  }
}
