import 'package:flutter/material.dart';
import 'package:icl/widgets/theme.dart';

abstract class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  String routeName();

  Widget title() {
    return Text(routeName(), style: MyTheme.title);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
