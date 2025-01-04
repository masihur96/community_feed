import 'package:community_feed_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildDarkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .05),
        color: Colors.white,
        fontWeight: FontWeight.w100,
      )),
      titleMedium: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, 0.04),
        color: Colors.white,
        fontWeight: FontWeight.w100,
      )),
      titleSmall: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .03),
        color: Colors.white,
        fontWeight: FontWeight.w300,
      )),
      bodyLarge: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .045),
        color: Colors.white,
        fontWeight: FontWeight.w900,
      )),
      bodyMedium: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .035),
        color: Colors.white,
        fontWeight: FontWeight.w500,
      )),
      bodySmall: GoogleFonts.figtree(
        textStyle: TextStyle(
          fontSize: screenSize(context, .03),
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
