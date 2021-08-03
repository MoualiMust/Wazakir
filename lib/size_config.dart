import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double scaleX(originalx, originalwidth, currentwidth){
  return(originalx * currentwidth / originalwidth);
}

double scaleY(originaly, originalheight, currentheight){
  return(originaly * currentheight / originalheight);
}

double heightSize(BuildContext context, double value){
  value /= 100;
  return MediaQuery.of(context).size.height * value;
}

double widthSize(BuildContext context,double value ){
  value /=100;
  return MediaQuery.of(context).size.width * value;
}
