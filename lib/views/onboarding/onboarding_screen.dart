import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/images.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/navigation/route_transition.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/views/dashboard/main_screen.dart';
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
                skipTextButton: Text(
                  skip,
                  style: text12SemiBold.copyWith(
                      color: isDarkMode ? kWhite : kBlack),
                ),
                controllerColor: isDarkMode ? kWhite : kBlack,
                centerBackground: true,
                finishButtonText: continue1,
                finishButtonTextStyle: text18SemiBold.copyWith(
                  color: kWhite,
                ),
                onFinish: () => RouteTransitions.navigateAndRemoveUntil(
                    context, const MainScreen(), 'Login'),
                finishButtonStyle: FinishButtonStyle(
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  backgroundColor: isDarkMode ? kWhite : kBlack,
                ),
                background: List.generate(
                    3,
                    (index) => const SizedBox(
                          width: 0,
                          height: 0,
                        )),
                speed: 1.0,
                pageBodies: List.generate(3, (index) {
                  String title = index == 0
                      ? onBoarding1Title
                      : index == 1
                          ? onBoarding2Title
                          : onBoarding3Title;
                  String description = index == 0
                      ? onBoarding1Description
                      : index == 1
                          ? onBoarding2Description
                          : onBoarding3Description;
                  String animation = index == 0
                      ? onBoarding1Animation
                      : index == 1
                          ? onBoarding2Animation
                          : onBoarding3Animation;
                  return _buildOnboardingPage(title, description, animation);
                }));
          },
        );
      },
    );
  }

  Widget _buildOnboardingPage(
      String title, String description, String animation) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Lottie.asset(animation),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: text40Bold,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: text18Regular,
          ),
        ],
      ),
    );
  }
}
