import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imcl/widgets/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget toolBar() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => showDialog(
              context: Get.context!,
              builder: (context) => const LoginDialog(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  Text("添加用户"),
                  SizedBox(width: 7),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => showDialog(
              context: Get.context!,
              builder: (context) => const AddGameDialog(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  Text("添加游戏"),
                  SizedBox(width: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridView() {
    final data = List.generate(20, (index) => Color(0xFFBAABBA - 2 * index));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.333,
        shrinkWrap: true,
        children: data
            .map(
              (e) => Card(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("游戏列表", style: TextStyle(fontSize: 32)),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    gridView(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        toolBar(),
      ],
    );
  }
}
