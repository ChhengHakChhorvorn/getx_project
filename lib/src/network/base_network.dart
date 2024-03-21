import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alice_helper.dart';
import 'base_dio.dart';

class BaseNetworkService {
  late dio.Response<dynamic> response;

  Future<T> postRequest<T>({
    dynamic payload,
    String? contentType,
  }) async {
    final baseDio = await _getBaseDio();

    if (contentType != null) {
      baseDio.http.options.headers['content-type'] = contentType;
    } else {
      baseDio.http.options.headers['Content-Type'] = "application/json";
    }

    baseDio.http.options.headers['Accept'] = "application/json";

    // baseDio.http.options.headers['X-Device-Information'] =
    //     getDeviceInformation();

    // String firebaseToken = await authController.getAccessTokenLocal();
    //
    // baseDio.http.options.headers['Authorization'] = "Bearer $firebaseToken";

    try {
      response = await baseDio.http.post(
        requestUrl(),
        data: payload,
      );
    } on DioError catch (error) {
      return responseError(error);
    }
    if (response.statusCode == 204) {
      return responseType(true);
    }

    if (response.statusCode == 200) {
      final returnData = jsonDecode(response.toString());
      if (returnData?['data']?.isEmpty == true) {
        return responseType(true);
      }
    }

    final json = jsonDecode(response.toString());

    return responseType(json) as T;
  }

  Future<T> getRequest<T>({
    Map<String, dynamic>? queryParameters,
  }) async {
    final BaseDio baseDio = await _getBaseDio();


    baseDio.http.options.headers['x-authorization-method'] = "firebase";
    baseDio.http.options.headers['X-Device-Type'] = "Mobile";

    // baseDio.http.options.headers['X-Device-Information'] =
    //     getDeviceInformation();

    baseDio.http.options.headers['Content-Type'] = "application/json";

    // baseDio.http.options.headers['Authorization'] = "Bearer $firebaseToken";

    try {
      response = await baseDio.http.get(
        requestUrl(),
        queryParameters: queryParameters,
      );
    } on DioError catch (error) {
      return responseError(error);
    }

    final json = jsonDecode(response.toString());

    return responseType(json) as T;
  }

  Future<T> putRequest<T>({
    dynamic payload,
    String? contentType,
  }) async {
    final BaseDio baseDio = await _getBaseDio();

    if (contentType != null) {
      baseDio.http.options.headers['content-type'] = contentType;
    } else {
      baseDio.http.options.headers['Content-Type'] = "application/json";
    }


    // baseDio.http.options.headers['X-Device-Information'] =
    //     getDeviceInformation();

    // baseDio.http.options.headers['Authorization'] = "Bearer $firebaseToken";

    try {
      response = await baseDio.http.put(requestUrl(), data: payload);
    } on DioError catch (error) {
      return responseError(error);
    }
    /*
    if (response.statusCode == 204) {
      return responseType(true);
    }

    if (response.statusCode == 200) {
      final returnData = jsonDecode(response.toString());
      if (returnData?['data']?.isEmpty == true) {
        return responseType(true);
      }
    }
    */
    final json = jsonDecode(response.toString());
    return responseType(json) as T;
  }

  Future<T> deleteRequest<T>({dynamic payload, }) async {
    final BaseDio baseDio = await _getBaseDio();

    // baseDio.http.options.headers['X-Push-Token'] = await getDevicePushToken();


    // baseDio.http.options.headers['Authorization'] = "Bearer $firebaseToken";

    try {
      response = await baseDio.http.delete(requestUrl(), data: payload);
    } on DioError catch (error) {
      return responseError(error);
    }

    final json = jsonDecode(response.toString());
    return responseType(json) as T;
  }

  Future<T> patchRequest<T>({dynamic payload}) async {

    final BaseDio baseDio = await _getBaseDio();

    // baseDio.http.options.headers['Authorization'] = "Bearer $firebaseToken";

    try {
      response = await baseDio.http.patch(requestUrl(), data: payload);
    } on DioError catch (error) {
      return responseError(error);
    }

    final json = jsonDecode(response.toString());
    return responseType(json) as T;
  }

  Future downloadPostRequest({
    dynamic payload,
    required String savePath,
  }) async {
    final baseDio = await _getBaseDio();
    baseDio.http.options.responseType = ResponseType.bytes;
    response = await baseDio.http.post(requestUrl(), data: payload);

    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
  }

  Future downloadGetRequest({
    dynamic queryParameters,
    required String savePath,
  }) async {
    final BaseDio baseDio = await _getBaseDio();
    baseDio.http.options.responseType = ResponseType.bytes;
    response =
        await baseDio.http.get(requestUrl(), queryParameters: queryParameters);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
  }

  dynamic responseType(dynamic json) {
    throw 'Missing response type';
  }

  dynamic responseError(DioError error) {
    throw error;
  }

  String requestUrl() {
    throw 'Missing request url';
  }

  Future<BaseDio> _getBaseDio() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final BaseDio baseDio = BaseDio(
        baseURL: dotenv.env['BASE_URL'] ?? '',);
    baseDio.addInterceptor(alice.getDioInterceptor());
    return baseDio;
  }
}
