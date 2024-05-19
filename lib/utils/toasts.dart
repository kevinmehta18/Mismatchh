import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:toastification/toastification.dart';

showToast(
    BuildContext context,
    String title, {
      ToastificationType? toastType,
    }) {
  Color shadowColor;
  switch (toastType) {
    case ToastificationType.error:
      shadowColor = kRed.withOpacity(0.5);
      break;
    case ToastificationType.info:
      shadowColor = kBlue.withOpacity(0.5);
      break;
    case ToastificationType.warning:
      shadowColor = kYellow.withOpacity(0.5);
      break;
    default:
      shadowColor = kGreen.withOpacity(0.5);
  }
  toastification.dismissAll();
  toastification.show(
    context: context,
    title: Text(
      title,
      style: text14SemiBold,
    ),
    autoCloseDuration: const Duration(seconds: 2),
    alignment: Alignment.topCenter,
    animationDuration: kAnimationDuration,
    borderRadius: BorderRadius.circular(8),
    type: toastType ?? ToastificationType.success,
    style: ToastificationStyle.fillColored,
    boxShadow: [BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 5)],
    closeButtonShowType: CloseButtonShowType.none,
    margin: EdgeInsets.zero,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    progressBarTheme: ProgressIndicatorThemeData(
        color: kWhite, linearTrackColor: kWhite.withOpacity(0.5)),
  );
}
