import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

ThemeData lightTheme = ThemeData(
    textTheme: lightThemeFonts,
    scaffoldBackgroundColor: kWhite,
    useMaterial3: false);

ThemeData darkTheme = ThemeData.dark(
  useMaterial3: false,
).copyWith(
  textTheme: darkThemeFonts,
  scaffoldBackgroundColor: kBlack,
);
