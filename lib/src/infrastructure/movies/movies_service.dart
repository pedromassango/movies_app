import 'package:dio/dio.dart';
import 'package:movies/api_configs.dart';

class MoviesService {
  final Dio dio;
  static const String apiKey = API_KEY;

  MoviesService({required this.dio});

}
