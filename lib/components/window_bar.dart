import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

class WindowsBar extends StatelessWidget {
  const WindowsBar({super.key});

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
    var buttonColors = WindowButtonColors(
      normal: Get.theme.tabBarTheme.labelColor,
      iconNormal: Colors.black,
      mouseOver: Get.theme.tabBarTheme.labelColor,
      mouseDown: Get.theme.focusColor,
      iconMouseOver: const Color.fromRGBO(0, 0, 0, 1),
      iconMouseDown: const Color.fromRGBO(0, 0, 0, 1),
    );

    return Row(children: [
      MinimizeWindowButton(colors: buttonColors, animate: true),
      MaximizeWindowButton(colors: buttonColors, animate: true),
      CloseWindowButton(colors: buttonColors, animate: true)
    ]);
  }
}
