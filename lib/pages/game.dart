import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:icl/interface/window_bar.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = ["开始游戏", "配置"];
    const routes = ["/home", "/setup"];
    final key = GlobalKey<NavigatorState>();
    var index = 0;
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
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: 105,
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
                                    tabs:
                                        tabs.map((e) => Tab(text: e)).toList(),
                                    onTap: (value) {
                                      if (index != value) {
                                        key.currentState?.pushReplacementNamed(
                                            routes[value]);
                                      }
                                      index = value;
                                    },
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
              Expanded(
                child: Navigator(
                  key: key,
                  initialRoute: routes[index],
                  onGenerateRoute: (settings) {
                    switch (settings.name) {
                      case '/home':
                        return createRoute(const _HomePage());
                      case '/setup':
                        return createRoute(const _SetupPage());
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
