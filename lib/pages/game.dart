import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:icl/interface/window_bar.dart';
import 'package:icl/widgets/transition.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ["开始游戏", "配置"];
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "image",
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
          FadeTransitionBuilder(
            child: Container(
              height: 105,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    offset: const Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.white.withOpacity(.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WindowTitleBar(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "1.8",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                width: 180,
                                child: DefaultTabController(
                                  length: tabs.length,
                                  child: TabBar(
                                    dividerColor: Colors.transparent,
                                    labelColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withGreen(150),
                                    labelStyle: Theme.of(context)
                                        .tabBarTheme
                                        .labelStyle
                                        ?.copyWith(
                                          fontSize: 14,
                                        ),
                                    tabs:
                                        tabs.map((e) => Tab(text: e)).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
