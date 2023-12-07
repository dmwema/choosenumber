import 'package:flutter/material.dart';

class SizeConfigs {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double screenShortSide;
  static late double defaultSize;
  static late Orientation orientation;

  static double textXXXLarge = 38;
  static double textXXLarge = 34;
  static double textXLarge = 30;
  static double textLarge = 26;
  static double textBig = 22;
  static double textMedium = 18;
  static double textSmall = 15;
  static double textTiny = 12;

  static double formInputWidth = 370;
  static double formBtnWidth = 270;
  static double formInputLabel = textMedium;
  static double formInputIcon = formInputLabel + 2;

  static double backIcon = 30.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenShortSide = _mediaQueryData.size.shortestSide;
    orientation = _mediaQueryData.orientation;
  }
}

double getAppropriateSize(double small, double medium, double large) {
  return isMobile()
      ? small
      : isTablet()
          ? medium
          : large;
}

bool isMobile() {
  return SizeConfigs.screenWidth <= 640;
  //return SizeConfig.screenWidth < 850;
}

bool isTablet() {
  return SizeConfigs.screenWidth < 1008 && SizeConfigs.screenWidth > 640;
  // return SizeConfig.screenWidth < 1100 && SizeConfig.screenWidth >= 850;
}

bool isDesktop() {
  return SizeConfigs.screenWidth >= 1008;
  //return SizeConfig.screenWidth >= 1100;
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfigs.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfigs.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Get the proportionate side as per screen short size
double getShortSize(double inputSide) {
  double screenShortSide = SizeConfigs.screenShortSide;
  // 375 is the layout width that designer use
  return (inputSide / 375.0) * screenShortSide;
}
