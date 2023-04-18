import 'package:flutter/material.dart';

class MyTheme {
  //
  //  浅色主题
  //
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'MiSans',
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
        extensions: [ShadowButtonTheme.light],
        scaffoldBackgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        appBarTheme: lightAppBarTheme(),
        dividerTheme: lightDividerTheme(),
        dialogTheme: lightDialogTheme(),
        snackBarTheme: lightSnackbarTheme(),
      );
  static AppBarTheme lightAppBarTheme() =>
      ThemeData.light().appBarTheme.copyWith(
            backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
          );
  static DividerThemeData lightDividerTheme() =>
      ThemeData.light().dividerTheme.copyWith(
            color: const Color.fromRGBO(197, 197, 197, 1),
          );

  static SnackBarThemeData lightSnackbarTheme() => ThemeData.light().snackBarTheme.copyWith(
    behavior: SnackBarBehavior.floating,
    width: 200,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
    backgroundColor: Colors.white38,
  );
  static DialogTheme lightDialogTheme() =>
      ThemeData.light().dialogTheme.copyWith(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5)),
          );
  //
  //  深色主题
  //
  static ThemeData darkTheme() => ThemeData(
        fontFamily: 'MiSans',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        extensions: [ShadowButtonTheme.dark],
        scaffoldBackgroundColor: const Color.fromRGBO(58, 58, 58, 1),
        appBarTheme: darkAppBarTheme(),
        dividerTheme: darkDividerTheme(),
        dialogTheme: darkDialogTheme(),
        snackBarTheme: darkSnackbarTheme()
      );
  static darkAppBarTheme() => ThemeData.dark().appBarTheme.copyWith(
        backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
      );
  static darkDividerTheme() => ThemeData.dark().dividerTheme.copyWith(
        color: const Color.fromRGBO(104, 104, 104, 1),
      );
  static darkSnackbarTheme() => ThemeData.dark().snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        width: 200,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(16),
  );
  static darkDialogTheme() => ThemeData.dark().dialogTheme.copyWith(
        backgroundColor: darkAppBarTheme().backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
      );

  // 自定义字体
  static final title = TextStyle(fontSize: 32);
  static final secondTitle = TextStyle(fontSize: 24);

  // 自定义规格
  static final borderRadius = BorderRadius.circular(7.5);
}

class ShadowButtonTheme extends ThemeExtension<ShadowButtonTheme> {
  const ShadowButtonTheme({
    required this.background,
  });
  final Color? background;

  @override
  ThemeExtension<ShadowButtonTheme> copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
  }) {
    return ShadowButtonTheme(
      background: success ?? this.background,
    );
  }

  @override
  ThemeExtension<ShadowButtonTheme> lerp(
    covariant ThemeExtension<ShadowButtonTheme>? other,
    double t,
  ) {
    if (other is! ShadowButtonTheme) {
      return this;
    }
    return ShadowButtonTheme(
      background: Color.lerp(background, other.background, t),
    );
  }

  // the light theme
  static const light =
      ShadowButtonTheme(background: Color.fromRGBO(247, 247, 247, 1));
  // the dark theme
  static const dark =
      ShadowButtonTheme(background: Color.fromRGBO(77, 77, 77, 1));
}
