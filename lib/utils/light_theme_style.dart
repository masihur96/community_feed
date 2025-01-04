import 'package:community_feed_app/utils/screen_size.dart';
import 'package:flutter/material.dart';

ThemeData buildLightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: screenSize(context, .05),
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
      titleMedium: TextStyle(
        fontSize: screenSize(context, 0.04),
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
      titleSmall: TextStyle(
        fontSize: screenSize(context, .03),
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: screenSize(context, .045),
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: screenSize(context, .035),
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: screenSize(context, .03),
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
