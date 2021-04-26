import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

BaseOptions options;
String url =
    "https://dev.hirephpcoder.com/toothpix/api/web/v1/"; //live
String commonAuth = "638a02b2-0ebc-4996-9e05-2b52d5f1b157";

Dio getDio({String key}) {
  if (key != null) {
    options = BaseOptions(
        baseUrl: url,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        headers: {
          "Connection": "Keep-Alive",
          "auth-key": key,
          "authentication": commonAuth
        });
  } else {
    options = BaseOptions(
        baseUrl: url,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        headers: {"Connection": "Keep-Alive", "authentication": commonAuth});
  }

  Dio dio = Dio(options);
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    request: true,
    compact: true,
  ));
  return dio;
}
