import 'package:community_feed_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildLightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.figtree(
        textStyle: TextStyle(
          fontSize: screenSize(context, .05),
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      titleMedium: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, 0.04),
        color: Colors.black,
        fontWeight: FontWeight.w400,
      )),
      titleSmall: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .03),
        color: Colors.black,
        fontWeight: FontWeight.w200,
      )),
      bodyLarge: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .045),
        color: Colors.black,
        fontWeight: FontWeight.w600,
      )),
      bodyMedium: GoogleFonts.figtree(
          textStyle: TextStyle(
        fontSize: screenSize(context, .035),
        color: Colors.black,
        fontWeight: FontWeight.w400,
      )),
      bodySmall: GoogleFonts.figtree(
        textStyle: TextStyle(
          fontSize: screenSize(context, .03),
          color: Colors.black,
          fontWeight: FontWeight.w200,
        ),
      ),
    ),
  );
}
