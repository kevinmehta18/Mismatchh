import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/images.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/navigation/route_transition.dart';
import 'package:mismatchh/views/dashboard/main_screen.dart';
import 'package:mismatchh/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody1(),
    );
  }

  Widget _buildBody1() {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2; // Adjust if you have more/less pages
            });
          },
          children: List.generate(3, (index) {
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
          }),
        ),
        Positioned(
          right: 16,
          top: 40,
          child: Visibility(
            visible: !isLastPage,
            child: TextButton(
              onPressed: () => _pageController.jumpToPage(2),
              child: Text(skip, style: text18SemiBold.copyWith(color: kBlack)),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: isLastPage
              ? CustomButton(
                  text: continue1,
                  onPressed: () => RouteTransitions.navigateAndRemoveUntil(
                      context, const MainScreen(), 'Login'),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        expansionFactor: 2.5,
                        dotHeight: 8,
                        dotColor: kGrey.withOpacity(0.3),
                        activeDotColor: kBlack,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildOnboardingPage(
      String title, String description, String animation) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.45,
            child: Lottie.asset(animation),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: text32Bold,
          ),
          const SizedBox(
            height: 10,
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
