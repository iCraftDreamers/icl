import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/theme.dart';

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

  Widget navigation(context) {
    List<Widget> children(RxInt currentIndex) {
      const icons = {
        [Icons.people, Icons.people_outline],
        [Icons.apps, Icons.apps_outlined],
        [Icons.palette, Icons.palette_outlined],
        [Icons.settings, Icons.settings_outlined],
      };
      const routes = {
        "用户": "/account",
        "库": "/home",
        "外观": "/appearance",
        "设置": "/setting",
      };
      const boxShadow = [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 2),
          blurRadius: 3,
        )
      ];
      final selectedColor = Theme.of(context).colorScheme.onPrimary;
      final children = List<Widget>.generate(
        routes.length,
        (i) => _NavigationButton(
          route: routes.values.elementAt(i),
          text: routes.keys.elementAt(i),
          icon: Icon(icons.elementAt(i)[0], color: selectedColor),
          unselectIcon: Icon(icons.elementAt(i)[1]),
          isSelected: currentIndex.value == i,
          onTap: () {
            Get.offNamed(id: 1, routes.values.elementAt(i));
            currentIndex(i);
          },
          boxShadow: i == 0 ? boxShadow : null,
        ),
      );
      children.insert(1, const SizedBox(height: 15));
      children.insert(children.length - 1, const Spacer());
      return children;
    }

    return Container(
      width: 200,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: GetX(
        init: _NavigatorController(),
        builder: (c) => Column(
          children: children(c.currentIndex),
        ),
      ),
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

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.route,
    required this.text,
    required this.icon,
    required this.unselectIcon,
    this.isSelected = false,
    this.onTap,
    this.boxShadow,
  });

  final String route;
  final String text;
  final Icon icon;
  final Icon unselectIcon;
  final bool isSelected;
  final void Function()? onTap;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final seletedColor = colors.primary;
    return AnimatedContainer(
      height: 54,
      clipBehavior: Clip.antiAlias,
      duration: Duration(milliseconds: isSelected ? 200 : 0),
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: isSelected
            ? seletedColor
            : boxShadow == null
                ? seletedColor.withOpacity(0)
                : colors.surface,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: seletedColor.withOpacity(.5),
          onTap: isSelected ? () {} : onTap,
          child: Row(
            children: [
              const SizedBox(width: 10),
              isSelected ? icon : unselectIcon,
              const SizedBox(width: 5),
              Text(
                text,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: isSelected ? colors.onPrimary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
