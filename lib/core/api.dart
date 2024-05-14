import 'package:dating/core/config.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = Config.baseUrl;
    _dio.options.headers = Config.header;
    _dio.options.responseDecoder;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true,
    ));
  }

  Dio get sendRequest => _dio;
}
