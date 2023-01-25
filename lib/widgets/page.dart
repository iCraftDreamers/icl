import 'package:flutter/widgets.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key});

  String pageName();
}

mixin BasicPage on BasePage {
  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(pageName(), style: const TextStyle(fontSize: 32)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return head();
  }
}
