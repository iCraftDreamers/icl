import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ["开始游戏", "配置"];
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text(
                      "1.8",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 180,
                      child: DefaultTabController(
                        length: tabs.length,
                        child: TabBar(
                          tabs: tabs.map((e) => Tab(text: e)).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 400,
                  child: Hero(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
