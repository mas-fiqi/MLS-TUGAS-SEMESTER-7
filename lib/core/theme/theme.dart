import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Constants
const Color kPrimaryColor = Color(0xFF9C27B0); // Soft Purple
const Color kGradientStart = Color(0xFFF3E5F5); // Light Purple
const Color kGradientEnd = Color(0xFFFFFFFF); // White
const Color kAccentColor = Color(0xFF00C853);
const Color kTextColor = Color(0xFF212121);
const Color kBackgroundColor = Color(0xFFFFFFFF);

// Text Styles
const TextStyle kHeadingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const TextStyle kBodyStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: kTextColor,
);

// App Theme
final ThemeData appTheme = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kPrimaryColor,
    secondary: kAccentColor,
    surface: kBackgroundColor,
  ),
  textTheme: GoogleFonts.interTextTheme(
    const TextTheme(
      displayLarge: kHeadingStyle,
      bodyLarge: kBodyStyle,
    ),
  ),
  useMaterial3: true,
);
