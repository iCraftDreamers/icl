import 'package:flutter/material.dart';
import 'package:icl/widgets/theme.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key});

  String pageName();
}

mixin BasicPage on BasePage {
  Widget head(BuildContext context) {
    return Text(pageName(), style: MyThemes.title);
  }

  @override
  Widget build(BuildContext context) {
    return head(context);
  }
}
