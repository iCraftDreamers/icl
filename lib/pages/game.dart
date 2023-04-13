import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/interface/window_bar.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ["开始游戏", "配置"];
    var boxShadow = RxList<BoxShadow>();
    var opacity = .0.obs;
    Timer(const Duration(milliseconds: 200), () => opacity(1));
    Timer(
      const Duration(milliseconds: 700),
      () {
        boxShadow.clear();
        boxShadow.add(
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 30,
            blurStyle: BlurStyle.outer,
          ),
        );
      },
    );
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "image",
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/background/2020-04-11_20.30.41.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedOpacity(
              opacity: opacity.value,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 105,
                decoration: BoxDecoration(boxShadow: boxShadow.toList()),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white.withOpacity(.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const WindowTitleBar(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(Icons.arrow_back),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "1.8",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(),
                                    ),
                                    const SizedBox(width: 10),
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
                                      tabs: tabs
                                          .map((e) => Tab(text: e))
                                          .toList(),
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
          ),
        ],
      ),
    );
  }
}
