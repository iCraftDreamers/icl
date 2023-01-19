import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: const Color.fromRGBO(215, 215, 215, 1),
        ),
    highlightColor: const Color.fromRGBO(235, 235, 235, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(225, 225, 225, 1),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          backgroundColor: const Color.fromRGBO(68, 68, 68, 1),
        ),
  );
  static final textTheme = ThemeData.light().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      );
}
