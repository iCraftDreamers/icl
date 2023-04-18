import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/widgets/theme.dart';

import '/pages/account.dart';
import '/pages/home.dart';
import '/pages/appearance.dart';
import '/pages/setting.dart';

class _NavigatorController extends GetxController {
  var currentIndex = 1.obs;
}

class WindowSurface extends StatelessWidget {
  const WindowSurface({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        navigation(context),
        const VerticalDivider(width: 1),
        navigationView(context),
      ],
    );
  }

  Widget navigationButton(int index, String routeName, String text,
      IconData icon, IconData unselectIcon, BuildContext context) {
    final controller = Get.put(_NavigatorController());
    return Obx(
      () => AnimatedContainer(
        height: 54,
        clipBehavior: Clip.antiAlias,
        duration: Duration(
            milliseconds: controller.currentIndex.value == index ? 200 : 0),
        decoration: BoxDecoration(
          borderRadius: MyTheme.borderRadius,
          color: controller.currentIndex.value == index
              ? Theme.of(context).colorScheme.primary
              : index == 0
                  ? Theme.of(context).extension<ShadowButtonTheme>()!.background
                  : Theme.of(context).colorScheme.primary.withOpacity(0),
          boxShadow: index == 0
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2), // 阴影的颜色
                    offset: const Offset(0, 5), // 阴影与容器的距离
                    blurRadius: 10.0, // 高斯的标准偏差与盒子的形状卷积。
                    spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              if (controller.currentIndex.value != index) {
                controller.currentIndex(index);
                Get.offNamed(routeName, id: 1);
              }
            },
            child: Row(
              children: [
                const SizedBox(width: 10),
                controller.currentIndex.value == index
                    ? Icon(icon, color: Colors.white)
                    : Icon(unselectIcon),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: TextStyle(
                    color: controller.currentIndex.value == index
                        ? Colors.white
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navigation(context) {
    const items = {
      "账号": [Icons.people, Icons.people_outline],
      "库": [Icons.apps, Icons.apps_outlined],
      "外观": [Icons.palette, Icons.palette_outlined],
      "设置": [Icons.settings, Icons.settings_outlined],
    };
    const List<String> routeName = [
      "/account",
      "/home",
      "/appearance",
      "/setting",
    ];
    var i = 0;
    List<Widget> children = [];
    items.forEach(
      (key, value) => children.add(
        navigationButton(
            i++, routeName[i - 1], key, value[0], value[1], context),
      ),
    );
    children.insert(1, const SizedBox(height: 15));
    children.insert(children.length - 1, const Spacer());

    return Container(
      width: 200,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(children: children),
    );
  }

  Widget navigationView(context) {
    Route createRoute(final Widget widget) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SharedAxisTransition(
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: const Color.fromRGBO(0, 0, 0, 0),
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: widget,
        ),
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

    return Expanded(
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Navigator(
          key: Get.nestedKey(1),
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
