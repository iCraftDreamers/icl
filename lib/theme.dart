import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(7.5);

final class AppTheme {
  AppTheme({
    this.themeMode = ThemeMode.system,
    this.seedColor = SeedColor.blue,
  });

  ThemeMode themeMode;
  SeedColor seedColor;

  ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'MiSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor.color,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'MiSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor.color,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  factory AppTheme.fromJson(Map<String, dynamic> json) => AppTheme(
        themeMode: ThemeMode.values.byName(json['themeMode']),
        seedColor: SeedColor.values.byName(json['seedColor']),
      );

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.name,
        'seedColor': seedColor.name,
      };
}

enum SeedColor {
  blue(color: Colors.blue);

  final Color color;

  const SeedColor({required this.color});
}
