import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mismatchh/api_service/api_service.dart';
import 'package:mismatchh/modals/dashboard/users_list.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  int currentIndex = 0;
  ListQueue<int> navigationQueue = ListQueue();

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  /// Users list API
  List<UsersListData> usersList = [];

  Future getUsersList() async {
    startLoader();
    ApiService().networkService().getUsersList().then((value) {
      stopLoader();
      usersList = value.data!;
    });
    notifyListeners();
  }

  /// Clear Provider
  clearProvider() {
    isLoading = false;
    currentIndex = 0;
    navigationQueue.clear();
    usersList.clear();
  }
}
