import 'dart:io';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/game.dart';
import '/utils/file_picker.dart';
import '/utils/game/game.dart';
import '/widgets/page.dart';
import '/widgets/dialog.dart';

class HomePage extends RoutePage {
  const HomePage({super.key});

  @override
  String routeName() => "库";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Row(
            children: [
              title(),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () => Games.init(),
              )
            ],
          ),
          const SizedBox(height: 10),
          gridView(),
        ],
      ),
    );
  }

  Widget toolBar() {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () => showDialog(
                context: Get.context!,
                builder: (context) => addGameDialog(),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text("添加游戏"),
                    SizedBox(width: 7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addGameDialog() {
    final javaDirController = TextEditingController();
    final gameDirController = TextEditingController();

    return AlertDialog(
      title: const Text("添加游戏"),
      content: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTextField(
              icon: Icons.file_open,
              label: "Java路径",
              hintText: "java.exe",
              controller: javaDirController,
              onPressed: () async {
                final File? file = await filePicker(['exe']);
                javaDirController.text = file!.path;
              },
            ),
            const SizedBox(height: 10),
            IconTextField(
              icon: Icons.folder_open,
              label: "Minecraft路径",
              hintText: ".minecraft",
              controller: gameDirController,
              onPressed: () async {
                final File? file = await folderPicker();
                gameDirController.text = file!.path;
              },
            ),
          ],
        ),
      ),
      actions: [
        DialogConfirmButton(onPressed: () {}),
        DialogCancelButton(onPressed: () {}),
      ],
    );
  }

  Widget gridView() {
    const versions = ["1.8"];
    final children = versions
        .map(
          (e) => _OpenContainerWrapper(
            closedBuilder: (_, openContainer) =>
                _Card(title: e, openContainer: openContainer),
            transitionType: ContainerTransitionType.fade,
            onClosed: (bool? _) {},
            page: const GamePage(),
          ),
        )
        .toList();
    return GridView.extent(
      maxCrossAxisExtent: 150,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1 / 1.333,
      shrinkWrap: true,
      children: children,
    );
  }
}

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final String hintText;
  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed ?? () {},
          icon: Icon(icon),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5))),
              hintText: hintText,
              label: Text(label),
            ),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.openContainer});

  final String title;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    var hover = false.obs;
    return Stack(
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
        Flex(
          direction: Axis.vertical,
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    color: Colors.white.withOpacity(.1),
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.black.withOpacity(.1),
            onTap: openContainer,
            onHover: (value) => hover(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
        ),
        Obx(
          () => TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: const Offset(0, 51),
              end: hover.value ? const Offset(0, 0) : const Offset(0, 51),
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.linearToEaseOut,
            builder: (context, offset, child) =>
                Transform.translate(offset: offset, child: child),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MouseRegion(
                  onEnter: (event) => hover(true),
                  onExit: (event) => hover(false),
                  child: FloatingActionButton.small(
                    onPressed: () => {print("原神，启动！")},
                    heroTag: null,
                    child: const Icon(Icons.play_arrow),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.page,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      useRootNavigator: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.5),
      ),
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const GamePage();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
