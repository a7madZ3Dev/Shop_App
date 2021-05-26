import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// LIGHT THEME
final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  fontFamily: 'Jannah',
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  iconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    elevation: 20.0,
  ),
);

// DARK THEME
final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  primaryColorDark: Colors.blue,
  fontFamily: 'Jannah',
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    elevation: 0.0,
    centerTitle: true,
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w900,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.blue,
      elevation: 20.0),
);
