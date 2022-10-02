import 'package:flutter/material.dart';

class AppTheme {
  static final blackColor = Color.fromRGBO(28, 29, 38, 1);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: blackColor,
        elevation: 2,
        shadowColor: const Color.fromRGBO(228, 76, 101, 1)),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: Colors.redAccent)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(228, 76, 101, 1),
      shape: const StadiumBorder(),
      elevation: 10,
    )),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      floatingLabelStyle: TextStyle(color: blackColor),
      hintStyle: TextStyle(color: blackColor),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
