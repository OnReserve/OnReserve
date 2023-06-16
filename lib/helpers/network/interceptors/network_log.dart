// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:on_reserve/helpers/log/logger.dart';

Interceptor loggerInterceptor = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    logger(Dio).i('REQUEST[${options.method}] => PATH: ${options.path} => ');
    // logger(Dio).i('HEADERS: ${options.headers} => BODY: ${options.data}');

    return handler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler handler) {
    logger(Dio).i(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => DATA: ${response.data}');

    return handler.next(response);
  },
  onError: (DioException e, ErrorInterceptorHandler handler) {
    logger(Dio)
        .e('ERROR[${e.response?.statusCode}] => PAYLOAD: ${e.response?.data}');

    return handler.next(e); //continue
  },
);
