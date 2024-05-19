import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
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