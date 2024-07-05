import 'package:flutter/material.dart';

// СВЕТЛАЯ ТЕМА
// Support Colors
const Color supSeparetor = Color.fromRGBO(0, 0, 0, 0.2);
const Color supOverlay = Color.fromRGBO(0, 0, 0, 0.06);
const Color supNavBarBlur = Color.fromRGBO(251, 251, 251, 0.8);

// Label Colors
const Color labPrimary = Color.fromRGBO(0, 0, 0, 1.0);
const Color labSecondary = Color.fromRGBO(0, 0, 0, 0.6);
const Color labTernitary = Color.fromRGBO(0, 0, 0, 0.3);
const Color labDisable = Color.fromRGBO(0, 0, 0, 0.15);

// Task Colors
const Color tdRed = Color.fromRGBO(255, 59, 48, 1.0);
const Color tdGreen = Color.fromRGBO(52, 199, 89, 1.0);
const Color tdBlue = Color.fromRGBO(0, 122, 255, 1.0);
const Color tdGrey = Color.fromRGBO(142, 142, 147, 1.0);
const Color tdGreyLight = Color.fromRGBO(209, 209, 214, 1.0);
const Color tdWhite = Color.fromRGBO(255, 255, 255, 1.0);

// Back Colors
const Color backIosPrimary = Color.fromRGBO(242, 242, 247, 1.0);
const Color backPrimary = Color.fromRGBO(247, 246, 242, 1.0);
const Color backSecondary = Color.fromRGBO(255, 255, 255, 1.0);
const Color backElevated = Color.fromRGBO(255, 255, 255, 1.0);

// ТЕМНАЯ ТЕМА
// Support Colors
const Color supSeparetorDark = Color.fromRGBO(0, 0, 0, 0.2);
const Color supOverlayDark = Color.fromRGBO(0, 0, 0, 0.32);
const Color supNavBarBlurDark = Color.fromRGBO(26, 26, 26, 0.9);

// Label Colors
const Color labPrimaryDark = Color.fromRGBO(255, 255, 255, 1.0);
const Color labSecondaryDark = Color.fromRGBO(255, 255, 255, 0.6);
const Color labTernitaryDark = Color.fromRGBO(255, 255, 255, 0.4);
const Color labDisableDark = Color.fromRGBO(255, 255, 255, 0.15);

// Task Colors
const Color tdRedDark = Color.fromRGBO(255, 69, 58, 1.0);
const Color tdGreenDark = Color.fromRGBO(50, 215, 75, 1.0);
const Color tdBlueDark = Color.fromRGBO(10, 132, 255, 1.0);
const Color tdGreyDark = Color.fromRGBO(142, 142, 147, 1.0);
const Color tdGreyLightDark = Color.fromRGBO(72, 72, 74, 1.0);
const Color tdWhiteDark = Color.fromRGBO(255, 255, 255, 1.0);

// Back Colors
const Color backIosPrimaryDark = Color.fromRGBO(0, 0, 0, 1.0);
const Color backPrimaryDark = Color.fromRGBO(60, 60, 63, 1.0);
const Color backSecondaryDark = Color.fromRGBO(37, 37, 40, 1.0);
const Color backElevatedDark = Color.fromRGBO(22, 22, 24, 1.0);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: tdBlue,
  backgroundColor: backPrimary,
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
    bodyText1: TextStyle(color: labPrimary),
    bodyText2: TextStyle(color: labSecondary),
    caption: TextStyle(color: labTernitary),
    button: TextStyle(color: tdBlue),
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
  primaryColor: tdBlueDark,
  backgroundColor: backPrimaryDark,
  scaffoldBackgroundColor: backPrimaryDark,
  appBarTheme: AppBarTheme(
    color: backPrimaryDark,
    iconTheme: IconThemeData(color: labPrimaryDark),
    titleTextStyle: TextStyle(
      color: labPrimaryDark,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: labPrimaryDark),
    bodyText2: TextStyle(color: labSecondaryDark),
    caption: TextStyle(color: labTernitaryDark),
    button: TextStyle(color: tdBlueDark),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: backSecondaryDark,
    hintStyle: TextStyle(color: labTernitaryDark),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: tdBlueDark,
    textTheme: ButtonTextTheme.primary,
  ),
);
