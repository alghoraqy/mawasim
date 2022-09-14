import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://mawasims.com.sa/api',
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json', 'Accept-Language': 'ar'}));
  }

  static Future<Response> getData(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio!.get(path, queryParameters: query);
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.post(path, data: data, queryParameters: query);
  }
}
