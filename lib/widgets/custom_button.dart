import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? borderColor;
  final double borderRadius;
  final TextStyle? btnTextStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.borderRadius = 8.0,
    this.borderColor, this.btnTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (ctx, themeProvider) => themeProvider.isDarkMode,
      builder: (BuildContext context, isDarkMode, Widget? child) {
        return MaterialButton(
          onPressed: onPressed,
          animationDuration: kAnimationDuration,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: bgColor ?? (isDarkMode ? kWhite : kBlack),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              )),
          padding: const EdgeInsets.symmetric(
            vertical: 14.0,
          ),

          child: Text(
            text,
            style: btnTextStyle ?? text14SemiBold.copyWith(
              color: isDarkMode ? kBlack : kWhite,
            ),
          ),
        );
      },
    );
  }
}
