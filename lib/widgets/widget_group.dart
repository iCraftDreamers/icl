import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icl/theme.dart';

import '../controller/storage.dart';

class WidgetGroup extends StatelessWidget {
  const WidgetGroup({
    super.key,
    required this.divider,
    required this.children,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline,
  });

  final Widget divider;
  final List<Widget> children;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip? clipBehavior;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    for (int i = 1; i < children.length; i += 2) {
      children.insert(i, divider);
    }
    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.apply(
          bodyColor: colors.onSecondaryContainer,
        ),
      ),
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        margin: margin,
        padding: padding,
        clipBehavior: clipBehavior ?? Clip.none,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: kBorderRadius,
              color: colors.secondaryContainer,
            ),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        ),
      ),
    );
  }
}

class ExpandListTile extends StatelessWidget {
  const ExpandListTile({
    super.key,
    required this.tile,
    required this.expandTile,
    required this.sizeFactor,
  });

  final Widget tile;
  final Widget expandTile;
  final Animation<double> sizeFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tile,
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: sizeFactor,
          child: expandTile,
        ),
      ],
    );
  }
}
