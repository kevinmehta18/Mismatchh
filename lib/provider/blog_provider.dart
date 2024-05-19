import 'package:flutter/material.dart';

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}