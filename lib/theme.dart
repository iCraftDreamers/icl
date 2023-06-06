import 'dart:math';

import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(7.5);

Color colorWithValue(Color color, double value) {
  final hsvColor = HSVColor.fromColor(color);
  return hsvColor.withValue(min(max(hsvColor.value + value, -1), 1)).toColor();
}

final class AppTheme {
  AppTheme({
    this.mode = ThemeMode.system,
    this.color = SeedColor.blue,
  });

  ThemeMode mode;
  SeedColor color;

  ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'MiSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: color.color,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'MiSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: color.color,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  factory AppTheme.fromJson(Map<String, dynamic> json) => AppTheme(
        mode: ThemeMode.values.byName(json['mode']),
        color: SeedColor.values.byName(json['color']),
      );

  Map<String, dynamic> toJson() => {
        'mode': mode.name,
        'color': color.name,
      };
}

enum SeedColor {
  blue(color: Colors.blue);

  final Color color;

  const SeedColor({required this.color});
}
