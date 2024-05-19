import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {super.key,
      this.title,
      this.description,
      required this.confirmBtnText,
      required this.cancelBtnText,
      required this.onConfirmTap,
      required this.onCancelTap,
      this.titleStyle,
      this.descriptionStyle,
      this.btnHeight,
      this.btnWidth});

  final String? title;
  final String? description;
  final String confirmBtnText;
  final String cancelBtnText;
  final VoidCallback onConfirmTap;
  final VoidCallback onCancelTap;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final double? btnHeight;
  final double? btnWidth;

  @override
  State<StatefulWidget> createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: ShapeDecoration(
                color: kWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.title != null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      widget.title ?? '',
                      style: widget.titleStyle ??
                          text14SemiBold.copyWith(color: kBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Visibility(
                    visible: widget.title != null,
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01)),
                Visibility(
                  visible: widget.description != null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 15, right: 15),
                    child: Text(widget.description ?? "",
                        style: widget.descriptionStyle ??
                            text18Regular.copyWith(color: kBlack),
                        textAlign: TextAlign.center),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  child: Selector<ThemeProvider, bool>(
                    selector: (ctx, themeProvider) => themeProvider.isDarkMode,
                    builder:
                        (BuildContext context, bool isDarkMode, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomButton(
                              borderRadius: 6,
                              borderColor:
                                  isDarkMode ? Colors.transparent : kBlack,
                              bgColor: isDarkMode ? kBlack : kWhite,
                              btnTextStyle: text14SemiBold.copyWith(
                                  color: isDarkMode ? kWhite : kBlack),
                              onPressed: () {
                                widget.onCancelTap();
                              },
                              text: widget.cancelBtnText,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: CustomButton(
                              borderRadius: 6,
                              borderColor:
                                  isDarkMode ? kBlack : Colors.transparent,
                              bgColor: isDarkMode ? kWhite : kBlack,
                              btnTextStyle: text14SemiBold.copyWith(
                                  color: isDarkMode ? kBlack : kWhite),
                              onPressed: () {
                                widget.onConfirmTap();
                              },
                              text: widget.confirmBtnText,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
