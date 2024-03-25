import 'package:flutter/material.dart';
import 'package:neat/utlis/constants/colors.dart';
ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: TColors.backgroundColor,
    primary: TColors.backgroundColor.withOpacity(0.5),
    secondary: TColors.backgroundColor.withOpacity(0.3),
    tertiary: TColors.backgroundColor.withOpacity(0.2),
    inversePrimary: TColors.primaryColor,
  )
);