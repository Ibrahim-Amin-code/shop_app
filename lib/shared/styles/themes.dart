
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(


  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(        // فيه حجات خاصه بال appBar بس هتطبق علي الابلكيشن كله
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backwardsCompatibility: false, // هنه بخليه false عشتان اقدر اتحكم في ال StatesBar
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.green, // ده ال بيتحكم في لون البار ال فوء خالص ال فيه الوقت والتاريخ
        statusBarIconBrightness: Brightness.dark
    ),
    elevation: 0.0,
    backgroundColor: Colors.white, // كده ده اتطبق في الابلكيشن كله
    titleTextStyle: TextStyle(
      color: Colors.black, // هنه بيتحكم ف لون كل ال texts ال موجوده في ال titles
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20,
    unselectedItemColor: Colors.grey,
    backgroundColor:Colors.white,

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),

);


ThemeData darkTheme = ThemeData(

  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(   // فيه حجات خاصه بال appBar بس هتطبق علي الابلكيشن كله
    titleSpacing: 20,
    backwardsCompatibility: false, // هنه بخليه false عشتان اقدر اتحكم في ال StatesBar
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'), // ده ال بيتحكم في لون البار ال فوء خالص ال فيه الوقت والتاريخ
        statusBarIconBrightness: Brightness.light
    ),
    elevation: 0.0,
    backgroundColor: HexColor('333739'), // كده ده اتطبق في الابلكيشن كله
    titleTextStyle: TextStyle(
      color: Colors.white, // هنه بيتحكم ف لون كل ال texts ال موجوده في ال titles
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
);

