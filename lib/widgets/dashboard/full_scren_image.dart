import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class FullScreenGalleryView extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenGalleryView({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  FullScreenGalleryViewState createState() => FullScreenGalleryViewState();
}

class FullScreenGalleryViewState extends State<FullScreenGalleryView> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context, _currentIndex);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, _currentIndex);
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: kYellow,
              )),
        ),
        body: Stack(
          children: [
            PageView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: widget.images.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fadeOutDuration: kAnimationDuration,
                  fadeInDuration: kAnimationDuration,
                  fadeOutCurve: Curves.easeIn,
                  fadeInCurve: Curves.easeOut,
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Selector<ThemeProvider, bool>(
                selector: (ctx, themeProvider) => themeProvider.isDarkMode,
                builder: (BuildContext context, isDarkMode, Widget? child) {
                  return Container(
                    height: 100,
                    color: isDarkMode ? kWhite : kBlack,
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentIndex = index;
                                _pageController.jumpToPage(index);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              width: 80,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      _currentIndex == index ? kYellow : kGrey,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.images[index],
                                fadeOutDuration: kAnimationDuration,
                                fadeInDuration: kAnimationDuration,
                                fadeOutCurve: Curves.easeIn,
                                fadeInCurve: Curves.easeOut,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
