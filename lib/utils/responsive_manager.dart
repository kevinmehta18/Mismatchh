import 'package:flutter/widgets.dart';

class ResponsiveManager {
  static late double _screenWidth;
  static late double _screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  static double width(double percent) {
    final blockSizeHorizontal = _screenWidth / 100;
    return blockSizeHorizontal * percent;
  }

  static double height(double percent) {
    final blockSizeVertical = _screenHeight / 100;
    return blockSizeVertical * percent;
  }

  static double fontSize(double percent) {
    return width(percent); 
  }
}
