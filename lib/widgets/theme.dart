import 'package:flutter/material.dart';

class MyThemes {
  //
  //  浅色主题
  //
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    highlightColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    dividerTheme: lightDividerTheme,
  );
  static final DividerThemeData lightDividerTheme =
      ThemeData.light().dividerTheme.copyWith(
            color: const Color.fromRGBO(197, 197, 197, 1),
          );

  //
  //  深色主题
  //
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    highlightColor: const Color.fromRGBO(84, 84, 84, 1),
    appBarTheme: darkAppBarTheme,
    dividerTheme: darkDividerTheme,
  );
  static final AppBarTheme darkAppBarTheme =
      ThemeData.dark().appBarTheme.copyWith(
            backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
          );
  static final DividerThemeData darkDividerTheme =
      ThemeData.dark().dividerTheme.copyWith(
            color: const Color.fromRGBO(104, 104, 104, 1),
          );
}
