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
    extensions: [AccNvgButtonTheme.light],
    scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
    dividerTheme: lightDividerTheme,
    dialogTheme: lightDialogTheme,
    buttonTheme: lightButtonTheme,
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
  static final ButtonThemeData lightButtonTheme =
      ThemeData.light().buttonTheme.copyWith();

  //
  //  深色主题
  //
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'MiSans',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue, brightness: Brightness.dark),
    useMaterial3: true,
    extensions: [AccNvgButtonTheme.dark],
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

class AccNvgButtonTheme extends ThemeExtension<AccNvgButtonTheme> {
  const AccNvgButtonTheme({
    required this.background,
  });
  final Color? background;

  @override
  ThemeExtension<AccNvgButtonTheme> copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
  }) {
    return AccNvgButtonTheme(
      background: success ?? this.background,
    );
  }

  @override
  ThemeExtension<AccNvgButtonTheme> lerp(
    covariant ThemeExtension<AccNvgButtonTheme>? other,
    double t,
  ) {
    if (other is! AccNvgButtonTheme) {
      return this;
    }
    return AccNvgButtonTheme(
      background: Color.lerp(background, other.background, t),
    );
  }

  // the light theme
  static const light =
      AccNvgButtonTheme(background: Color.fromRGBO(247, 247, 247, .9));
  // the dark theme
  static const dark =
      AccNvgButtonTheme(background: Color.fromRGBO(66, 66, 66, .9));
}
