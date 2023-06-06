import 'package:flutter/material.dart';
import 'package:icl/theme.dart';

class WidgetGroup extends StatelessWidget {
  const WidgetGroup({
    super.key,
    required this.divider,
    required this.children,
    this.width,
    this.height,
    this.backgroundColor,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
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
  final Color? backgroundColor;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
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
      child: Material(
        color: backgroundColor ?? colors.secondaryContainer,
        borderRadius: kBorderRadius,
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          margin: margin,
          padding: padding,
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
      ),
    );
  }
}

class TitleWidgetGroup extends StatelessWidget {
  const TitleWidgetGroup({
    super.key,
    required this.title,
    required this.divider,
    required this.children,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.clipBehavior,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline,
  });

  final Widget title;
  final Widget divider;
  final List<Widget> children;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
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

    Widget surface(Widget widget) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: borderRadius ?? kBorderRadius,
          color: color ?? colorWithValue(colors.secondaryContainer, .1),
          elevation: 2,
          child: widget,
        ),
      );
    }

    List<Widget> children = () {
      var children = this.children;
      children = children.map((e) => surface(e)).toList();
      return [title] + children;
    }();

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
        padding: padding ?? const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? kBorderRadius,
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
