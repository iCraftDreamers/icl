import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(7.5);

class MyTheme {
  //
  //  浅色主题
  //
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'MiSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      );
  //
  //  深色主题
  //
  static ThemeData darkTheme() => ThemeData(
        fontFamily: 'MiSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
}
