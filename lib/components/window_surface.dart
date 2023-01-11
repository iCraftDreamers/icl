import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:imcl/routes/home.dart';
import 'package:imcl/routes/appearance.dart';
import 'package:imcl/routes/setting.dart';
import 'package:imcl/widgets/button.dart';

import '../widgets/route_builder.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [navigationBar(), navigationView()],
    );
  }

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
      color: Get.theme.tabBarTheme.labelColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  // ----------------RightSize----------------
  Widget navigationView() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: Get.theme.splashColor,
        child: Navigator(
          key: Get.nestedKey(1), // create a key by index
          initialRoute: '/home',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/home':
                return createRoute(const HomePage());
              case '/appearance':
                return createRoute(AppearancePage());
              case '/setting':
                return createRoute(const SettingPage());
            }
          },
        ),
      ),
    );
  }
}
