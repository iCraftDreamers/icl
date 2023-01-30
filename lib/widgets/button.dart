import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/pages.dart';

abstract class Button extends StatelessWidget {
  const Button({super.key});

  final borderRadius = 7.5;
}

class NavigationButton extends Button {
  const NavigationButton({
    super.key,
    required this.lable,
    required this.icon,
    required this.unselectedIcon,
    required this.index,
  });

  final String lable;
  final IconData icon;
  final IconData unselectedIcon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PagesController());
    const List<String> routeName = [
      "/home",
      "/appearance",
      "/setting",
    ];

    return GestureDetector(
      onTap: () {
        if (c.current.value != index) {
          c.current(index);
          Get.offAndToNamed(routeName[c.current.value], id: 1);
        }
      },
      child: Obx(
        () => Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: c.current.value == index
                ? Theme.of(context).colorScheme.primary
                : const Color.fromRGBO(255, 255, 255, 0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              c.current.value == index
                  ? Icon(icon, color: Colors.white)
                  : Icon(unselectedIcon),
              const SizedBox(width: 5),
              Text(
                lable,
                style: TextStyle(
                    color: c.current.value == index ? Colors.white : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
