import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/strings.dart';
import 'package:mismatchh/provider/dashboard/dashboard_provider.dart';
import 'package:mismatchh/provider/theme_provider.dart';
import 'package:mismatchh/views/dashboard/chat_list_screen.dart';
import 'package:mismatchh/views/dashboard/home_screen.dart';
import 'package:mismatchh/views/dashboard/liked_you_screen.dart';
import 'package:mismatchh/views/dashboard/profile_screen.dart';
import 'package:mismatchh/widgets/bottom_bar_list.dart';
import 'package:mismatchh/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    if (provider.navigationQueue.isEmpty) {
      provider.navigationQueue.add(0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (a) async {
        await _onWillPop();
      },
      canPop: false,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBody() {
    return Selector<DashboardProvider, int>(
      selector: (ctx, provider) => provider.currentIndex,
      builder: (BuildContext context, int currentIndex, Widget? child) {
        switch (currentIndex) {
          case 0:
            return const HomeScreen();
          case 1:
            return const LikedYouScreen();
          case 2:
            return const ChatListScreen();
          case 3:
            return const ProfileScreen();
          default:
            return const SizedBox();
        }
      },
    );
  }


  Widget _buildBottomNavigationBar() {
    return Consumer2<DashboardProvider, ThemeProvider>(
      builder: (BuildContext context, provider, themeProvider, Widget? child) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: kYellow,
            currentIndex: provider.currentIndex,
            elevation: 3,
            onTap: (index) {
              if (provider.currentIndex != index) {
                provider.onTapped(index,);
              }
            },
            items: bottomBarItems);
      },
    );
  }




  Future<bool> _onWillPop() async {
    var provider = Provider.of<DashboardProvider>(context, listen: false);
    if (provider.navigationQueue.length > 1) {
      provider.navigationQueue.removeLast();
      int previousIndex = provider.navigationQueue.last;
      setState(() {
        provider.currentIndex = previousIndex;
      });
      return false;
    } else {
      bool confirmedExit = await showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: exitApp,
          description: exitDialogDesc,
          confirmBtnText: yes,
          cancelBtnText: no,
          onCancelTap: () {
            Navigator.pop(context, false);
          },
          onConfirmTap: () {
            SystemNavigator.pop();
          },
        ),
      ) ??
          false;
      return confirmedExit;
    }
  }

}
