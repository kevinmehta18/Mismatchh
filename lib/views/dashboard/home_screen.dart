import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/images.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/provider/dashboard/home_provider.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/views/dashboard/profile_detail_screen.dart';
import 'package:mismatchh/widgets/dashboard/swipe_indicator_tag.dart';
import 'package:mismatchh/widgets/dashboard/user_preview_card.dart';
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
        print('New list length ::::::>>>>>${provider.usersList.length}');
        return provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: kYellow,
              ))
            : provider.usersList.isNotEmpty
                ? Column(
                    children: [
                      Flexible(
                        child: CardSwiper(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                          cardsCount: provider.usersList.length,
                          cardBuilder: (BuildContext context, index,
                              percentThresholdX, percentThresholdY) {
                            final String id =
                                provider.usersList[index].id.toString();
                            final String profileImg =
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
                                UserPreviewCard(
                                  imageUrl: profileImg,
                                  name: name,
                                  age: age,
                                  interests: interests,
                                  distance: distance,
                                  onTap: () {
                                    _onCardTap(id, name, age, profileImg,
                                        interests, distance);
                                  },
                                ),
                                if (percentThresholdX < -0.7) // Swiped left
                                  if (percentThresholdX < -0.7) // Swiped left
                                    _buildDisLikeTag(),
                                if (percentThresholdX > 0.7) // Swiped right
                                  _buildLikeTag(),
                                // ,
                              ],
                            );
                          },
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.symmetric(
                                  horizontal: true),
                          isLoop: false,
                          onSwipe: _onSwipe,
                          onUndo: (previousIndex, currentIndex, direction) {
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
                    ],
                  )
                : const Text('No data');
      },
    );
  }

  Widget _buildLikeTag() {
    return SwipeIndicatorTag(
        text: like,
        textStyle: likeButtonStyle,
        borderColor: kGreen,
        backgroundColor: kGreen.withOpacity(0.2),
        angle: 0.5,
        top: MediaQuery.of(context).size.height * 0.06,
        horizontalPadding: 25);
  }

  Widget _buildDisLikeTag() {
    return SwipeIndicatorTag(
        text: dislike,
        textStyle: disLikeButtonStyle,
        borderColor: kRed,
        backgroundColor: kRed.withOpacity(0.2),
        angle: -0.5,
        top: MediaQuery.of(context).size.height * 0.06,
        horizontalPadding: 15);
  }


  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    // var provider = Provider.of<HomeProvider>(context, listen: false);
    // debugPrint("list before deleting:::::::\n${provider.usersList.length}");
    // if(direction == CardSwiperDirection.left){
    //   print("calling api like with ${provider.usersList[previousIndex].name}");
    // }
    // if(direction == CardSwiperDirection.right){
    //   print("calling api dislike with ${provider.usersList[previousIndex].name}");
    // }
    // provider.usersList.removeAt(previousIndex);
    // provider.notifyListeners();
    // debugPrint("==========================================================");
    // debugPrint("list after deleting:::::::\n${provider.usersList.length}");
    return true;
  }

  _onCardTap(String id, String name, String age, String profileImg,
      List<String> interests, String distance) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileDetailScreen(
          id: id,
          name: name,
          imageList: [profileImg,profileImg],
          age: age,
          interests: interests,
          distance: distance,
        ),
      ),
    );
  }

  /// API Calls------------------------------------------------
  Future getUsersList(HomeProvider provider) async {
    await provider.getUsersList();
  }
}
