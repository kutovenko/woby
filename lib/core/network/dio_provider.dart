import 'package:dio/dio.dart';

class DioProvider {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  DioProvider();

  void configureDio() {
    var options = BaseOptions(contentType: "application/json");
    _dio.options = options;
  }
}