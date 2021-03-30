
import 'package:dio/dio.dart';

Dio? _dioInstance;

class DioBuilder {
  final String baseUrl;

  DioBuilder({required this.baseUrl});

  Dio build() {
    if (_dioInstance == null) {
      final Dio dio = Dio();
      dio.options..baseUrl = baseUrl;
      _dioInstance = dio;
    }
    return _dioInstance!;
  }
}