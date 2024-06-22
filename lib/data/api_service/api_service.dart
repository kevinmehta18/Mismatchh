import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/main.dart';
import 'package:mismatchh/navigation/app_router.dart';
import 'package:mismatchh/presentation/provider/auth_provider.dart';
import 'package:mismatchh/presentation/provider/dashboard/home_provider.dart';
import 'package:mismatchh/shared_preference/shared_preference.dart';
import 'package:mismatchh/utils/toasts.dart';
import 'package:mismatchh/presentation//views/auth/login_screen.dart';

import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'network_service.dart';


class ApiService {
  NetworkService networkService({bool? isMultipartData}) {
    final dio = Dio();

    void showErrorToast(String message) {
      showToast(navigatorKey.currentContext!, message,toastType: ToastificationType.error);
    }

    void handleUnauthorizedResponse() {
      showErrorToast('Unauthorized');
      Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (ctx) => const LoginScreen()), (route) => false);
    }

    stopLoader() {
      var provider = Provider.of<AuthProvider>(navigatorKey.currentContext!, listen: false);
      var homeProvider = Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false);

      provider.stopLoader();
      homeProvider.stopLoader();

    }

    Future<void> refreshToken() async {
      final refreshToken = PrefUtils().getRefreshToken();
      if (refreshToken.isNotEmpty) {
        try {
          final response = await dio.post(
            'your_refresh_token_endpoint_url',
            data: {
              'refresh_token': refreshToken,
            },
          );
          final newAccessToken = response.data['data']['accessToken'];
          PrefUtils().saveAuthToken(newAccessToken);
        } catch (error) {
          // HelperFunction.clearAppData();
          // RouteTransitions.navigateAndRemoveUntil(
          //     navigatorKey.currentContext!, const Login(),);
        }
      }
    }

    bool isErrorResponse(int statusCode, Map<String, dynamic>? responseData) {
      return statusCode != 200 &&
          statusCode != 201 &&
          responseData != null &&
          responseData.containsKey('message');
    }

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = PrefUtils().getAuthToken().toString();
        if (accessToken.isEmpty) {
          await refreshToken();
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (!kReleaseMode) {
          print("Response receieved======================>>>>>>>");
        }
        try {
          final responseData = response.data as Map<String, dynamic>?;
          if (isErrorResponse(response.statusCode!, responseData)) {
            final errorMessage = responseData!['message'] as String;
            showErrorToast(errorMessage);
          }
        } catch (e, s) {
          if (!kReleaseMode) {
            print(e);
            print(s);
          }
        }
        handler.next(response);
      },
      onError: (DioException e, handler) {
        stopLoader();
        String errorMessage = '';
        final response = e.response;

        if (response != null) {
          if (e.response!.statusCode == 401) {
            showErrorToast("Unauthorized");
            handleUnauthorizedResponse();
          } else {
            final responseData = response.data;

            if (responseData != null && responseData is Map<String, dynamic>) {
              if (responseData.containsKey('message')) {
                errorMessage = responseData['message'].toString();
              }
              showErrorToast(errorMessage);
            }
          }

          if (!kReleaseMode) {
            print('Error Message -> $errorMessage,');
          }
        }
      },
    ));

    dio.options.connectTimeout = const Duration(milliseconds: 50000);
    dio.options.receiveTimeout = const Duration(milliseconds: 50000);
    dio.options.headers["Content-Type"] = (isMultipartData ?? false)
        ? "multipart/form-data"
        : "application/json";
    final accessToken = PrefUtils().getAuthToken().toString();
    if (accessToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return NetworkService(dio, baseUrl: "");
  }
}
