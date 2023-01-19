import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

class WindowBar extends StatelessWidget {
  const WindowBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget windowButtons() {
      final iconColor = Theme.of(context).iconTheme.color;
      final buttonColors = WindowButtonColors(
        normal: Colors.transparent,
        mouseOver: Get.theme.hoverColor,
        mouseDown: Get.theme.focusColor,
        iconNormal: iconColor,
        iconMouseOver: iconColor,
        iconMouseDown: iconColor,
      );

      return Row(
        children: [
          MinimizeWindowButton(colors: buttonColors, animate: true),
          MaximizeWindowButton(colors: buttonColors, animate: true),
          CloseWindowButton(colors: buttonColors, animate: true)
        ],
      );
    }

    return WindowTitleBarBox(
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("IMCL"),
                  ),
                ),
              ),
            ),
            windowButtons(),
          ],
        ),
      ),
    );
  }
}
