import 'package:dio/dio.dart';
import 'package:mismatchh/constants/urls.dart';
import 'package:mismatchh/data/api_service/models/dashboard/users_list.dart';
import 'package:retrofit/retrofit.dart';

import 'models/dashboard/chat_list.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: "")
abstract class NetworkService {
  factory NetworkService(Dio dio, {String? baseUrl}) = _NetworkService;

  @GET(usersList)
  Future<UsersList> getUsersList();
  
  @GET(chatList)
  Future<ChatList> getChatList();

  @GET(likedYouList)
  Future<UsersList> getLikedYouList();


}
