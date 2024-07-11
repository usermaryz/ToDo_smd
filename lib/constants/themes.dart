import '/constants/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: backPrimary,
  scaffoldBackgroundColor: backPrimary,
  appBarTheme: const AppBarTheme(
    color: backPrimary,
    iconTheme: IconThemeData(color: labPrimary),
    titleTextStyle: TextStyle(
      color: labPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: labPrimary),
    bodyMedium: TextStyle(color: labSecondary),
    bodySmall: TextStyle(color: labTernitary),
    labelLarge: TextStyle(color: tdBlue),
    labelMedium: TextStyle(color: tdRed),
    labelSmall: TextStyle(color: tdGrey),
    headlineLarge: TextStyle(color: tdGreen),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: tdWhite,
    hintStyle: const TextStyle(color: labTernitary),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: tdBlue,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: backIosPrimaryDark,
  scaffoldBackgroundColor: backIosPrimaryDark,
  appBarTheme: const AppBarTheme(
    color: backPrimaryDark,
    iconTheme: IconThemeData(color: labPrimaryDark),
    titleTextStyle: TextStyle(
      color: labPrimaryDark,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: labPrimaryDark),
    bodyMedium: TextStyle(color: labSecondaryDark),
    bodySmall: TextStyle(color: labTernitaryDark),
    labelLarge: TextStyle(color: tdBlueDark),
    labelMedium: TextStyle(color: tdRedDark),
    labelSmall: TextStyle(color: tdGreyDark),
    headlineLarge: TextStyle(color: tdGreenDark),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: backSecondaryDark,
    hintStyle: const TextStyle(color: labTernitaryDark),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: tdBlueDark,
    textTheme: ButtonTextTheme.primary,
  ),
);
