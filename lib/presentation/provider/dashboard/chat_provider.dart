import 'package:flutter/material.dart';
import 'package:mismatchh/data/api_service/api_service.dart';
import 'package:mismatchh/data/api_service/models/dashboard/chat_list.dart';

class ChatProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoader(bool isLoading) {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoader() {
    _isLoading = false;
    notifyListeners();
  }

  /// Get Chat list
  List<ChatListData> chatList = [];

  Future getChatList() async {
    startLoader(true);
    ApiService().networkService().getChatList().then((value) {
      stopLoader();
      chatList = value.data!;
      notifyListeners();
    });
  }
}
