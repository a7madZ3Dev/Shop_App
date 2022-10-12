import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<dynamic> getDataFromApi({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<dynamic> postDataToApi({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<dynamic> putDataToApi({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
