import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

class _AppWindowController extends GetxController {
  var isMaximize = appWindow.isMaximized.obs;
}

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key, this.title});

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_AppWindowController());
    final iconColor = Theme.of(context).iconTheme.color;
    final buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      mouseOver: Get.theme.hoverColor,
      mouseDown: Get.theme.focusColor,
      iconNormal: iconColor,
      iconMouseOver: iconColor,
      iconMouseDown: iconColor,
    );
    return WindowTitleBarBox(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: MoveWindow(
              onDoubleTap: () => {
                appWindow.maximizeOrRestore(),
                controller.isMaximize(!appWindow.isMaximized),
              },
              child: title ??
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("iCraft Launcher"),
                    ),
                  ),
            ),
          ),
          WindowButtons(colors: buttonColors),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key, this.colors, this.animate});

  final WindowButtonColors? colors;
  final bool? animate;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_AppWindowController());
    return Flex(
      direction: Axis.horizontal,
      children: [
        MinimizeWindowButton(colors: colors, animate: animate),
        Obx(
          () => controller.isMaximize.value
              ? RestoreWindowButton(
                  colors: colors,
                  animate: true,
                  onPressed: () => {
                    appWindow.maximizeOrRestore(),
                    controller.isMaximize(!appWindow.isMaximized),
                  },
                )
              : MaximizeWindowButton(
                  colors: colors,
                  animate: true,
                  onPressed: () => {
                    appWindow.maximizeOrRestore(),
                    controller.isMaximize(!appWindow.isMaximized),
                  },
                ),
        ),
        CloseWindowButton(colors: colors, animate: animate),
      ],
    );
  }
}

class NavigatorBackButton extends WindowButton {
  NavigatorBackButton({
    Key? key,
    EdgeInsets? padding,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    required BuildContext context,
  }) : super(
          key: key,
          colors: colors ??
              WindowButtonColors(
                normal: Colors.transparent,
                mouseOver: Get.theme.hoverColor,
                mouseDown: Get.theme.focusColor,
                iconNormal: Theme.of(context).iconTheme.color,
                iconMouseOver: Theme.of(context).iconTheme.color,
                iconMouseDown: Theme.of(context).iconTheme.color,
              ),
          animate: animate ?? false,
          padding: EdgeInsets.zero,
          iconBuilder: (buttonContext) => Icon(
            Icons.arrow_left,
            color: buttonContext.iconColor,
            size: 30,
          ),
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
        );
}
