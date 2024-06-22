import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/constants/textstyles.dart';
import 'package:mismatchh/presentation/provider/theme_provider.dart';
import 'package:mismatchh/presentation/widgets/dashboard/image_gallery_view.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen(
      {super.key,
      required this.name,
      required this.id,
      required this.imageList,
      required this.age,
      required this.distance,
      required this.interests});

  final String name;
  final String id;
  final List<String> imageList;
  final String age;
  final String distance;
  final List<String> interests;

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late ScrollController _scrollController;
  bool lastStatus = true;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height / 2;

    return Scaffold(
      body: _buildNestedScrollView(),
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
        physics: const ClampingScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollBehavior: const ScrollBehavior().copyWith(
          physics: const NeverScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
              _buildSliverAppBar(),
            ],
        body: _buildBody());
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: height,
      leading: _buildBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: _buildFlexibleSpaceBar(),
      ),
    );
  }

  Widget _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      background: _buildProductImageList(),
    );
  }

  Widget _buildProductImageList() {
    return SafeArea(
      child: ImageGalleryView(
        imageList: widget.imageList,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfo(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildInterests()),
            _buildLanguages()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: text20SemiBold,
    );
  }

  _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(basicInfo),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Passionate about travel, cooking, and outdoor adventures. Seeking a kind-hearted, adventurous soul for meaningful connection. Loves exploring new cultures and making memories. Let's embark on an exciting journey together!",
          style: text16Medium,
        ),
      ],
    );
  }

  _buildInterests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(interests),
        const SizedBox(
          height: 10,
        ),
        Selector<ThemeProvider, bool>(
          selector: (ctx, themeProvider) => themeProvider.isDarkMode,
          builder: (BuildContext context, isDarkMode, Widget? child) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.interests.map((interest) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kYellow.withOpacity(isDarkMode ? 0.3 : 0.1),
                    border: Border.all(color: kYellow),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    interests,
                    style: text14SemiBold.copyWith(
                        color: isDarkMode ? kWhite : kBlack),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  _buildLanguages() {
    List<String> languageList = [
      "English",
      "Hindi",
      "Marathi",
      "Tamil",
      "Telugu",
      "Malayalam",
      "Kannada",
      "Bengali",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(languages),
        const SizedBox(
          height: 10,
        ),
        Selector<ThemeProvider, bool>(
          selector: (ctx, themeProvider) => themeProvider.isDarkMode,
          builder: (BuildContext context, isDarkMode, Widget? child) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: languageList.map((language) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kYellow.withOpacity(isDarkMode ? 0.3 : 0.1),
                    border: Border.all(color: kYellow),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    language,
                    style: text14SemiBold.copyWith(
                        color: isDarkMode ? kWhite : kBlack),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
        ));
  }
}
