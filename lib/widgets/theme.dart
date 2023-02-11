import 'package:flutter/material.dart';

class MyThemes {
  //
  //  浅色主题
  //
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'MiSans',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    dividerTheme: lightDividerTheme,
    dialogTheme: lightDialogTheme,
  );
  static final DividerThemeData lightDividerTheme =
      ThemeData.light().dividerTheme.copyWith(
            color: const Color.fromRGBO(197, 197, 197, 1),
          );
  static final DialogTheme lightDialogTheme =
      ThemeData.light().dialogTheme.copyWith(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          );

  //
  //  深色主题
  //
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'MiSans',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue, brightness: Brightness.dark),
    useMaterial3: true,
    appBarTheme: darkAppBarTheme,
    navigationBarTheme: darkNavigationBarTheme,
    scaffoldBackgroundColor: const Color.fromRGBO(58, 58, 58, 1),
    dividerTheme: darkDividerTheme,
    dialogTheme: darkDialogTheme,
  );
  static final AppBarTheme darkAppBarTheme =
      ThemeData.dark().appBarTheme.copyWith(
            backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
          );
  static final NavigationBarThemeData darkNavigationBarTheme =
      ThemeData.dark().navigationBarTheme.copyWith(
            backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
          );
  static final DividerThemeData darkDividerTheme =
      ThemeData.dark().dividerTheme.copyWith(
            color: const Color.fromRGBO(104, 104, 104, 1),
          );
  static final DialogTheme darkDialogTheme =
      ThemeData.light().dialogTheme.copyWith(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          );
}
