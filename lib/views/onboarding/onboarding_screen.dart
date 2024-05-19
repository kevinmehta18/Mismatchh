import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/images.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Selector<ThemeProvider, bool>(
          selector: (ctx, themeProvider) => themeProvider.isDarkMode,
          builder: (BuildContext context, isDarkMode, Widget? child) {
            return OnBoardingSlider(
              totalPage: 3,
              headerBackgroundColor: Colors.transparent,
              hasSkip: true,
              skipTextButton: const Text(
                skip,
                style: text12Medium,
              ),
              controllerColor: isDarkMode ? kWhite : kBlack,
              finishButtonStyle: FinishButtonStyle(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                backgroundColor: isDarkMode ? kWhite : kBlack,
              ),
              background: const [
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
              speed: 1.0,
              pageBodies: [
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Lottie.asset(onBoarding1Animation),
                      ),
                      const Text(
                        onBoarding1Title,
                        textAlign: TextAlign.center,
                        style: text40Bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        onBoarding1Description,
                        textAlign: TextAlign.center,
                        style: text20SemiBold,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Lottie.asset(onBoarding2Animation),
                      ),
                      const Text(
                        onBoarding2Title,
                        textAlign: TextAlign.center,
                        style: text40Bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        onBoarding2Description,
                        textAlign: TextAlign.center,
                        style: text20SemiBold,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Lottie.asset(onBoarding3Animation),
                      ),
                      const Text(
                        onBoarding3Title,
                        textAlign: TextAlign.center,
                        style: text40Bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        onBoarding3Description,
                        textAlign: TextAlign.center,
                        style: text20SemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
