import 'package:flutter/material.dart';

class SwipeIndicatorTag extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color borderColor;
  final Color backgroundColor;
  final double angle;
  final double top;
  final double horizontalPadding;

  const SwipeIndicatorTag({super.key,
    required this.text,
    required this.textStyle,
    required this.borderColor,
    required this.backgroundColor,
    required this.angle,
    required this.top,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: angle < 0 ? 0 : null,
      right: angle > 0 ? 0 : null,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor, width: 2),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 35),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 5),
          child: Text(
            text.toUpperCase(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
