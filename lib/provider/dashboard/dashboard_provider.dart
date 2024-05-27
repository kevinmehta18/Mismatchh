import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mismatchh/api_service/api_service.dart';
import 'package:mismatchh/constants/urls.dart';
import 'package:mismatchh/constants/urls.dart';
import 'package:mismatchh/modals/dashboard/chat_list.dart';
import 'package:mismatchh/modals/dashboard/users_list.dart';

class DashboardProvider extends ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int currentIndex = 0;
  ListQueue<int> navigationQueue = ListQueue();


  startLoader() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    _isLoading = false;
    notifyListeners();
  }


  void onTapped(int index) {
    if (index == 0) {
      navigationQueue.clear();
    }
    currentIndex = index;
    navigationQueue.add(index);
    notifyListeners();
  }

  /// Get Chat list
  List<UsersListData> likedYouList = [];

  Future getLikedYouList() async {
    startLoader();
    ApiService().networkService().getLikedYouList().then((value) {
      stopLoader();
      likedYouList = value.data!;
      notifyListeners();
    });
  }

  /// Clear provider
  clearProvider() {
    likedYouList.clear();
    _isLoading = false;
    notifyListeners();
  }
}