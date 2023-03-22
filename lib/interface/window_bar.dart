import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

class WindowBar extends StatelessWidget {
  const WindowBar({super.key});

  @override
  Widget build(BuildContext context) {
    var isMaximize = false.obs;
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
          Obx(
            () => isMaximize.value
                ? RestoreWindowButton(
                    colors: buttonColors,
                    animate: true,
                    onPressed: () => {
                      appWindow.maximizeOrRestore(),
                      isMaximize(false),
                    },
                  )
                : MaximizeWindowButton(
                    colors: buttonColors,
                    animate: true,
                    onPressed: () => {
                      appWindow.maximizeOrRestore(),
                      isMaximize(true),
                    },
                  ),
          ),
          CloseWindowButton(colors: buttonColors, animate: true),
        ],
      );
    }

    return WindowTitleBarBox(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: MoveWindow(
                onDoubleTap: () => {
                  appWindow.maximizeOrRestore(),
                  isMaximize(!isMaximize.value),
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("iCraft Launcher"),
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
