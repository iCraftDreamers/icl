import 'package:flutter/widgets.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key});

  String pageName();
  final List<Widget> body = const <Widget>[];
}

mixin BasicPage on BasePage {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Text(pageName(), style: const TextStyle(fontSize: 32)),
      const SizedBox(height: 10),
    ];
    children.addAll(body);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
