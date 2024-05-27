import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/modals/dashboard/users_list.dart';
import 'package:mismatchh/provider/dashboard/dashboard_provider.dart';
import 'package:mismatchh/views/dashboard/profile_detail_screen.dart';
import 'package:mismatchh/widgets/dashboard/user_preview_card.dart';
import 'package:provider/provider.dart';

class LikedYouScreen extends StatefulWidget {
  const LikedYouScreen({super.key});

  @override
  State<LikedYouScreen> createState() => _LikedYouScreenState();
}

class _LikedYouScreenState extends State<LikedYouScreen> {
  Future? _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.likedYouList.clear();
      provider.notifyListeners();
      _future = getLikedYouList(provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Consumer<DashboardProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return RefreshIndicator(
                color: kYellow,
                child: provider.likedYouList.isNotEmpty
                    ? _buildGridView(provider.likedYouList)
                    : provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(
                            child: Text("No data found"),
                          ),
                onRefresh: () async {
                  provider.likedYouList.clear();
                  await getLikedYouList(provider);
                });
          },
        );
      },
    );
  }

  Widget _buildGridView(List<UsersListData> userList) {
    return GridView.builder(
      itemCount: userList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6, crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        String id = userList[index].id.toString();
        String imageUrl = userList[index].imageUrl.toString();
        String name = userList[index].name.toString();
        String age = userList[index].age.toString();
        String distance = userList[index].distance.toString();
        List<String> interests = userList[index].interests ?? [];
        return UserPreviewCard(
            imageUrl: imageUrl,
            name: name,
            age: age,
            distance: distance,
            onTap: () {
              _onCardTap(id, name, age, imageUrl, interests, distance);
            });
      },
    );
  }

  _onCardTap(String id, String name, String age, String profileImg,
      List<String> interests, String distance) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileDetailScreen(
          id: id,
          name: name,
          imageList: [profileImg, profileImg],
          age: age,
          interests: interests,
          distance: distance,
        ),
      ),
    );
  }

  /// API Calls-----------------------------------------
  Future getLikedYouList(DashboardProvider provider) async {
    await provider.getLikedYouList();
  }
}
