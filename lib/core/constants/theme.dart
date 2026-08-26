import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';


ThemeData myTheme = ThemeData(

  fontFamily: "FFShamel",
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColor.white , fontWeight: FontWeight.bold , fontSize: 20),
    displaySmall: TextStyle(color: AppColor.darkBlue , fontSize: 12 , fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: AppColor.white , fontSize: 16 , fontWeight: FontWeight.bold),
    displayLarge: TextStyle(color: AppColor.secondaryColor , fontSize: 20 , fontWeight: FontWeight.bold)

  ),
  dialogTheme: DialogTheme(
    shadowColor: Colors.black,
      surfaceTintColor:Colors.transparent,
      backgroundColor: Colors.transparent,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent , ),

);
