import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

abstract class _appWindow {
  static var isMaximize = appWindow.isMaximized.obs;
}

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key, required this.title});

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: MoveWindow(
              onDoubleTap: () => {
                appWindow.maximizeOrRestore(),
                _appWindow.isMaximize(!appWindow.isMaximized),
              },
              child: title ?? SizedBox(),
            ),
          ),
          WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    final buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      mouseOver: Get.theme.hoverColor,
      mouseDown: Get.theme.focusColor,
      iconNormal: iconColor,
      iconMouseOver: iconColor,
      iconMouseDown: iconColor,
    );
    return Flex(
      direction: Axis.horizontal,
      children: [
        MinimizeWindowButton(colors: buttonColors, animate: true),
        Obx(
          () => _appWindow.isMaximize.value
              ? RestoreWindowButton(
                  colors: buttonColors,
                  animate: true,
                  onPressed: () => {
                    appWindow.maximizeOrRestore(),
                    _appWindow.isMaximize(!appWindow.isMaximized),
                  },
                )
              : MaximizeWindowButton(
                  colors: buttonColors,
                  animate: true,
                  onPressed: () => {
                    appWindow.maximizeOrRestore(),
                    _appWindow.isMaximize(!appWindow.isMaximized),
                  },
                ),
        ),
        CloseWindowButton(colors: buttonColors, animate: true),
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
