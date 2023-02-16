import 'package:flutter/material.dart';
import 'package:icl/widgets/theme.dart';

class CardHighlight extends StatelessWidget {
  const CardHighlight({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: MyTheme.borderRadius,
        color: Theme.of(context).highlightColor,
      ),
      child: child,
    );
  }
}
