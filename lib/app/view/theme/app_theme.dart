import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = new ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(245, 246, 250, 1),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(48))),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()));
}
