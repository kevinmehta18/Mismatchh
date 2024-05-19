import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/images.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/provider/home_provider.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/widgets/swiping_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provider = Provider.of<HomeProvider>(context, listen: false);
      provider.usersList.clear();
      await getUsersList(provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Selector<ThemeProvider, bool>(
            selector: (ctx, themeProvider) => themeProvider.isDarkMode,
            builder: (BuildContext context, isDarkMode, Widget? child) {
              return SvgPicture.asset(
                preferences,
                colorFilter: ColorFilter.mode(
                    isDarkMode ? kWhite : kBlack, BlendMode.srcIn),
                height: 20,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, provider, Widget? child) {

        return provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: kYellow,
              ))
            : provider.usersList.isNotEmpty
                ? Column(
                    children: [
                      Flexible(
                        child: CardSwiper(
                          cardsCount: provider.usersList.length,
                          cardBuilder: (BuildContext context, index,
                              percentThresholdX, percentThresholdY) {
                            final String imageUrl =
                                provider.usersList[index].imageUrl.toString();
                            final String name =
                                provider.usersList[index].name.toString();
                            final String age =
                                provider.usersList[index].age.toString();
                            final List<String> interests =
                                provider.usersList[index].interests ?? [];
                            final String distance =
                                provider.usersList[index].distance.toString();
                            return Stack(
                              children: [
                                SwipingCard(
                                  imageUrl: imageUrl,
                                  name: name,
                                  age: age,
                                  interests: interests,
                                  distance: distance,
                                ),
                                if (percentThresholdX < -0.7) // Swiped left
                                  if (percentThresholdX < -0.7) // Swiped left
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.06,
                                      left: 0,
                                      child: Transform.rotate(
                                        angle: -0.5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: kRed.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: kRed, width: 2),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 35),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4),
                                          child: Text(
                                            dislike.toUpperCase(),
                                            style: disLikeButtonStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                if (percentThresholdX > 0.7) // Swiped right
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.06,
                                    // Adjust the vertical position as needed
                                    right: 00,
                                    child: Transform.rotate(
                                      angle: 0.5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kGreen.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: kGreen, width: 2),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 35),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 5),
                                        child: Text(
                                          like.toUpperCase(),
                                          // Replace dislike with your actual text
                                          style: likeButtonStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                // ,
                              ],
                            );
                          },
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.symmetric(
                                  horizontal: true),
                          isLoop: false,
                          onSwipe: (previousIndex,currentIndex,direction){
                            // provider.usersList.removeAt(previousIndex);
                            print(provider.usersList.length);
                            return true;
                          },
                          onUndo: (previousIndex,currentIndex,direction){
                            // provider.usersList.removeAt(currentIndex);
                            return true;
                          },
                          controller: controller,
                          maxAngle: 60,
                          duration: kCardSwipeDuration,
                          onEnd: () {
                            debugPrint('The card was swiped to the end');
                          },
                        ),
                      ),
                      Visibility(
                        visible: provider.usersList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Selector<ThemeProvider, bool>(
                            selector: (ctx, themeProvider) =>
                                themeProvider.isDarkMode,
                            builder: (BuildContext context, isDarkMode,
                                Widget? child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FloatingActionButton(
                                    onPressed: controller.undo,
                                    shape: const CircleBorder(),
                                    backgroundColor: isDarkMode ? kWhite : kBlack,
                                    child: const Icon(
                                      Icons.undo,
                                      color: kGreen,
                                      size: 30,
                                    ),
                                  ),
                                  FloatingActionButton(
                                    shape: const CircleBorder(),
                                    backgroundColor: isDarkMode ? kWhite : kBlack,
                                    onPressed: () => controller
                                        .swipe(CardSwiperDirection.left),
                                    child: const Icon(
                                      Icons.clear_rounded,
                                      color: kBlue,
                                      size: 30,
                                    ),
                                  ),
                                  FloatingActionButton(
                                    shape: const CircleBorder(),
                                    backgroundColor: isDarkMode ? kWhite : kBlack,
                                    onPressed: () => controller
                                        .swipe(CardSwiperDirection.right),
                                    child: const Icon(
                                      Icons.favorite,
                                      color: kRed,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Text('No data');
      },
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  /// API Calls------------------------------------------------
  Future getUsersList(HomeProvider provider) async {
    await provider.getUsersList();
  }
}
