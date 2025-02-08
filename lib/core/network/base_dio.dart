import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:erp_appp/core/network/json_response_convert.dart';
import 'package:erp_appp/core/network/token_interceptor.dart';
import 'package:flutter/foundation.dart';

class BaseDio {
  Dio createDio() {
    Dio request = Dio();
    // var gatewayBaseUrl = "https://dummyjson.com/";
    var gatewayBaseUrl = "";
    request.options.baseUrl = gatewayBaseUrl;
    request.options.followRedirects = true;
    request.options.validateStatus = (status) => true;
    request.options.contentType = Headers.jsonContentType;
    request.interceptors.add(TokenInterceptor());
    request.interceptors.add(JsonResponseConverter());
    if (kDebugMode) {
      request.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
      request.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }
    return request;
  }
}
