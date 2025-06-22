// Define color variables at the top
import 'package:flutter/material.dart';

const Color kBackgroundColor = Colors.black;
const Color kPrimaryColor = Colors.blue;
const Color kInactiveDotColor =
    Color(0xFF1A1A1A); // Colors.grey[850] equivalent
const Color kWhiteColor = Colors.white;
Color kFadedWhiteColor = Colors.blueGrey;

const TextTheme kTextTheme = TextTheme(
  displayLarge:
      TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: kWhiteColor),
  displayMedium:
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kWhiteColor),
  displaySmall:
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: kWhiteColor),
  headlineLarge:
      TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: kWhiteColor),
  headlineMedium:
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kWhiteColor),
  headlineSmall:
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kWhiteColor),
  titleLarge:
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kWhiteColor),
  bodyLarge: TextStyle(fontSize: 16, color: kWhiteColor),
  bodyMedium: TextStyle(fontSize: 14, color: kWhiteColor),
  titleMedium:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kWhiteColor),
  titleSmall:
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: kWhiteColor),
  labelLarge: TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: kPrimaryColor),
  bodySmall: TextStyle(fontSize: 12, color: kWhiteColor),
  labelSmall: TextStyle(fontSize: 10, color: kWhiteColor),
);
