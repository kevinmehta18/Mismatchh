import 'package:dio/dio.dart';
import 'package:mismatchh/constants/urls.dart';
import 'package:mismatchh/modals/home/users_list.dart';
import 'package:retrofit/retrofit.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: "")
abstract class NetworkService {
  factory NetworkService(Dio dio, {String? baseUrl}) = _NetworkService;

  @GET(usersList)
  Future<UsersList> getUsersList();


}
