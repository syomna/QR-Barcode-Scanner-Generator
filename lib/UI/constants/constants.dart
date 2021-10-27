import 'package:flutter/material.dart';

Color kPrimaryColor = Colors.pink.shade200;

String kHiveBox = 'scanner_codes';

ThemeData kLightMode = ThemeData(
    primaryColor: kPrimaryColor,
    primarySwatch: Colors.pink,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: kPrimaryColor),
    appBarTheme: AppBarTheme(centerTitle: true, color: kPrimaryColor));

ThemeData kDarkMode = ThemeData.dark().copyWith(
   primaryColor: kPrimaryColor,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: kPrimaryColor),
    appBarTheme: const  AppBarTheme(centerTitle: true)
);

navigateTo(context, widget) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));

navigateAndRemove(context, widget) => Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => widget), (route) => false);

kSnackBar(context, String message) => ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text(message)));
