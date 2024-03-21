
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import '../constants/constants.dart';

class BaseIntercepter extends Interceptor {
  String baseUrl;

  BaseIntercepter({required this.baseUrl});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final newOptions = setBearerToken(options);
    newOptions.baseUrl = baseUrl;
    newOptions.connectTimeout = 60000.milliseconds; // 60 second timeout
    newOptions.receiveTimeout = 60000.milliseconds; // 60 second timeout
    log('${newOptions.method}: ${newOptions.uri.toString()}');
    if (newOptions.data != null) {
      log('Request data: ${newOptions.data}');
    }
    // log('Header: ${newOptions.headers.toString()}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    log('--url:${err.requestOptions.path}--code:${err.response?.statusCode}--message:${err.response?.statusMessage}');
  }

  RequestOptions setBearerToken(RequestOptions options) {
    // any dio option are adding here
    final authorization = options.headers['Authorization'];
    final accessToken = getAccessToken();
    if (authorization == null && accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return options;
  }

  Future<String?> getAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(
      ConstantPreferenceKey.accessTokenKey,
    );
  }
}
