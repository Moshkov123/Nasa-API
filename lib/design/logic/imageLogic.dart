import 'package:flutter/material.dart';

class ScreenUtil {
  static Size calculateAdjustedScreenSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double adjustedScreenWidth;
    double adjustedScreenHeight;

    if (screenWidth < screenHeight) {
      // Device is in portrait mode, make the image take up the full width
      adjustedScreenWidth = screenWidth;
      adjustedScreenHeight = screenHeight * 0.3; // 30% of the screen height
    } else {
      // Device is in landscape mode, make the image 35% of the screen width
      adjustedScreenWidth = screenWidth * 0.75;
      adjustedScreenHeight = screenHeight * 0.75; // 75% of the screen height
    }

    return Size(adjustedScreenWidth, adjustedScreenHeight);
  }
}
