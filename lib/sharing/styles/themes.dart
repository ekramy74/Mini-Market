import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_market/sharing/styles/const.dart';

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      actionsIconTheme:
          IconThemeData(color: Colors.white, size: 25, opacity: .7),
      elevation: 0,
      backgroundColor: Colors.black,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w200),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.indigo[500],
      unselectedIconTheme: IconThemeData(
        size: 20,
      ),
      selectedIconTheme: IconThemeData(
        size: 29,
      ),
      elevation: 15,
      backgroundColor: Colors.black),
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white, fontSize: 16)),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultcolor,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.indigo[300]),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      actionsIconTheme: IconThemeData(color: Colors.black, size: 25),
      iconTheme: IconThemeData(color: Colors.black, size: 25),
      elevation: 0,
      backgroundColor: Colors.white,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.w300),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.indigo[300],
      selectedIconTheme: IconThemeData(
        size: 29,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20,
      ),
      elevation: 15,
      backgroundColor: Colors.white),
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 16)),
);
