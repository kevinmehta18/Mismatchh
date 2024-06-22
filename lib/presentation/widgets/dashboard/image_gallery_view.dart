import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/presentation/widgets/dashboard/full_screen_image.dart';

class ImageGalleryView extends StatefulWidget {
  final List<String> imageList;

  const ImageGalleryView({
    super.key,
    required this.imageList,
  });

  @override
  ImageGalleryViewState createState() => ImageGalleryViewState();
}

class ImageGalleryViewState extends State<ImageGalleryView> {
  late PageController _pageController;
  int _currentIndex = 0;
  late StreamSubscription<int> _streamSubscription;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    _streamSubscription =
        CurrentIndexStream().indexStream.listen((index) {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kYellow.withOpacity(0.1),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.imageList.length,
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _toggleFullScreen(),
                child: CachedNetworkImage(imageUrl:
                  widget.imageList[index],
                  fadeOutDuration: kAnimationDuration,
                  fadeInDuration: kAnimationDuration,
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,

                ),
              );
            },
          ),
          Visibility(
            visible: widget.imageList.length > 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.imageList.length; i++) {
      indicators.add(
          AnimatedContainer(
            width: (_currentIndex == i) ? 20 : 10,
            height: 6,
            duration: kCardSwipeDuration,
            curve: Curves.easeIn,
            margin: const EdgeInsets.only(right: 10,bottom: 10),
            decoration: BoxDecoration(
              color: _currentIndex == i ? kYellow : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          )

      );
    }
    return indicators;
  }

  void _toggleFullScreen() {
    setState(() {
      _currentIndex = _pageController.page?.toInt() ?? 0;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenGalleryView(
          images: widget.imageList,
          initialIndex: _currentIndex,
        ),
      ),
    ).then((value) {
      setState(() {
        _currentIndex = value;
        _pageController.jumpToPage(
          value,
        );
      });
    });
  }
}

class CurrentIndexStream {
  static final CurrentIndexStream _singleton = CurrentIndexStream._internal();
  factory CurrentIndexStream() => _singleton;

  CurrentIndexStream._internal();

  final _controller = StreamController<int>.broadcast();

  Stream<int> get indexStream => _controller.stream;

  void updateIndex(int index) {
    _controller.sink.add(index);
  }


}