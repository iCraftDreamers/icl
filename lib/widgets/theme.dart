import 'package:flutter/material.dart';

final textTheme = ThemeData.light().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );
final ThemeData lightTheme = ThemeData.light().copyWith();
final ThemeData darkTheme = ThemeData.dark().copyWith();
final ThemeData theme = ThemeData(
  primarySwatch: Colors.amber,
);
