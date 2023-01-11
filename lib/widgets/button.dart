import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/controllers/pages.dart';

abstract class Button extends StatelessWidget {
  const Button({super.key});

  final borderRadius = 7.5;
}

class NavigationButton extends Button {
  const NavigationButton({
    super.key,
    required this.lable,
    required this.icon,
    required this.index,
  });

  final IconData icon;
  final String lable;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PagesController()); // Controller

    return SizedBox(
      height: 54,
      child: GestureDetector(
        onTap: () {
          if (c.current.value != index) {
            c.updateCurrent(index.obs);
            Get.offAndToNamed(c.routeName[c.current.value], id: 1);
          }
        },
        child: GetBuilder<PagesController>(
          builder: (c) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: c.current.value == index
                  ? Get.theme.highlightColor
                  : Get.theme.tabBarTheme.labelColor,
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(icon),
                const SizedBox(width: 5),
                Text(lable),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
