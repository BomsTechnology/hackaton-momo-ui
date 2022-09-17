import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = Dio();

  dio.options.baseUrl = "https://api-hackaton.gomapguide.com/api/";
  dio.options.headers['accept'] = "Application/json";

  return dio;
}
