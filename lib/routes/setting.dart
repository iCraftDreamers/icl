import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/utils/games.dart';
import 'package:icl/utils/get_environment_variable.dart';

import '/widgets/page.dart';

class SettingPage extends BasePage with BasicPage {
  const SettingPage({super.key});

  @override
  String pageName() => "设置";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        head(),
        ValueBuilder<double?>(
          initialValue: 1024,
          builder: (value, updater) => Slider(
            value: value!,
            min: 512,
            max: 4096,
            divisions: 7,
            label: value.toInt().toString(),
            onChanged: (value) => updater(value),
          ),
        ),
        Row(
          children: [
            FilledButton(
              onPressed: () => getJavaOnEnvironmentVariable(),
              child: const Text("测试"),
            ),
            FilledButton(
              onPressed: () => GamesManaging().searchGames(),
              child: const Text("测试"),
            ),
          ],
        ),
      ],
    );
  }
}
