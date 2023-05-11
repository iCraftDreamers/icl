import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/interface/window_bar.dart';

import '../widgets/blurred.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/2020-04-11_20.30.41.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 105,
                child: Acrylic(
                  color: Colors.white,
                  blurValue: 5,
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
                                  onPressed: () => Navigator.of(context).pop(),
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
                              child: GetBuilder<_TabController>(
                                init: _TabController(),
                                builder: (c) => TabBar(
                                  controller: c.tabController,
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
                                      c.tabs.map((e) => Tab(text: e)).toList(),
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
              Expanded(
                child: GetBuilder(
                  init: _TabController(),
                  builder: (c) => TabBarView(
                    controller: c.tabController,
                    children: const [_HomePage(), _SetupPage()],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Route createRoute(final Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SharedAxisTransition(
        transitionType: SharedAxisTransitionType.horizontal,
        fillColor: const Color.fromRGBO(0, 0, 0, 0),
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: widget,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(.15, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class _TabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabs = ["开始游戏", "配置"];
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => this);
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "主页",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class _SetupPage extends StatelessWidget {
  const _SetupPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "配置",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
