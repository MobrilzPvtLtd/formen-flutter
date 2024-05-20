import 'dart:developer';

import 'package:dating/core/config.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  
  final Dio _dio = Dio();

  Api() {
    log(_dio.options.baseUrl);
    log(Config.baseUrl);
    log(Config.baseUrlApi);
    log(Config.religionlist);
    log(Config.baseUrlApi+Config.religionlist);
    log(Config.baseUrlApi+Config.getInterestList);
    StackTrace;
    _dio.options.baseUrl = Config.baseUrl;
    _dio.options.headers = Config.header;
    _dio.options.requestEncoder;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true,
    ));
  }

  Dio get sendRequest => _dio;
  
}
