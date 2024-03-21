
import 'package:dio/dio.dart';

import 'base_interceptor.dart';

class BaseDio {
  Dio http = Dio();
  final String baseURL;

  BaseDio({required this.baseURL, }) {
    // adding default interceptor
    addInterceptor(
      BaseIntercepter(
        baseUrl: baseURL,
      ),
    );
  }

  dynamic addInterceptor(Interceptor interceptor) {
    http.interceptors.add(interceptor);
  }

  dynamic removeInterceptor(Interceptor interceptor) {
    http.interceptors.remove(interceptor);
  }
}
