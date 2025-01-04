import 'package:flutter/material.dart';

double screenSize(BuildContext context, double partialSize) {
  // Get the width and height of the screen
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;

  // Determine if it's a mobile or desktop view
  if (screenWidth < 600) {
    // Mobile view: calculate based on width
    return screenWidth * partialSize;
  } else {
    // Desktop view: calculate based on height
    return screenHeight * partialSize;
  }
}
