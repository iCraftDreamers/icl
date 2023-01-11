import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

class WindowBar extends StatelessWidget {
  const WindowBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Get.theme.tabBarTheme.labelColor,
              child: MoveWindow(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("IMCL"),
                  ),
                ),
              ),
            ),
          ),
          const WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var iconColor = Get.theme.tabBarTheme.labelColor;
    var buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      mouseOver: Get.theme.hoverColor,
      mouseDown: Get.theme.focusColor,
      iconNormal: iconColor,
      iconMouseOver: iconColor,
      iconMouseDown: iconColor,
    );

    return Row(children: [
      MinimizeWindowButton(colors: buttonColors, animate: true),
      MaximizeWindowButton(colors: buttonColors, animate: true),
      CloseWindowButton(colors: buttonColors, animate: true)
    ]);
  }
}
