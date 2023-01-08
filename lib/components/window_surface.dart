import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/pages.dart';

import 'package:imcl/routes/home.dart';
import 'package:imcl/routes/appearance.dart';
import 'package:imcl/routes/setting.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [leftSize(), rightSize()],
    );
  }

  Widget leftSize() {
    return Container(
      width: 200,
      color: Get.theme.tabBarTheme.labelColor,
      child: _navigationRail(),
    );
  }

  Widget _navigationRail() {
    final pageController = Get.put(PagesController());

    Widget navigationButton(String text, dynamic icon, int index) {
      return SizedBox(
        height: 54,
        child: GestureDetector(
          onTap: () {
            if (pageController.current.value != index) {
              pageController.updateCurrent(index.obs);
              Get.offAndToNamed(
                pageController.routeName[pageController.current.value],
                id: 1,
              );
            }
          },
          child: GetBuilder<PagesController>(
            builder: (controller) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: pageController.current == index.obs
                    ? Get.theme.highlightColor
                    : Get.theme.tabBarTheme.labelColor,
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(icon),
                  const SizedBox(width: 5),
                  Text(text),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          navigationButton("主页", Icons.home, 0),
          navigationButton("外观", Icons.palette, 1),
          const Spacer(),
          navigationButton("设置", Icons.settings, 2),
        ],
      ),
    );
  }

  //----------------RightSize----------------

  Widget rightSize() {
    return Expanded(
      child: Container(
        color: Get.theme.splashColor,
        child: _buildContentByIndex(),
      ),
    );
  }

  Widget _buildContentByIndex() {
    Route createRoute(final Widget widget) {
      return PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.1);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    return Navigator(
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
      },
    );
  }
}
