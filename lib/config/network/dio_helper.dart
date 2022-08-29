import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'end_points.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl:baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status != null && status < 500;
        },
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    @required dynamic data,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
   
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
