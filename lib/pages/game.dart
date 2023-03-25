import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/interface/window_bar.dart';

import '/widgets/inner_shadow.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

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
    return Scaffold(
      body: Stack(
        children: [
          InnerShadow(
            blur: 20,
            shadowColor: Colors.black54,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background/2020-04-11_20.30.41.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        NavigatorBackButton(
                          context: context,
                          animate: true,
                          colors: buttonColors,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: WindowTitleBar(
                            title: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("iCraft Launcher"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: SizedBox(
                          height: 70,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow, size: 32),
                            label: Text(
                              "开始游戏",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
