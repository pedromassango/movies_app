import 'package:dio/dio.dart';
import 'package:movies/api_configs.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/infrastructure/movies/reponse_objects/movies_response.dart';
import 'package:tuple/tuple.dart';

import 'reponse_objects/movie_details_response.dart';

class MoviesService {
  final Dio dio;
  static const String apiKey = API_KEY;

  MoviesService({required this.dio});

  Future<Tuple2<MoviesResponse?, MovieLoadingError?>> getMovies({int page = 0}) async {
    try {
      final result = await dio.get('/trending/movie/day?api_key=$apiKey');
      final response = MoviesResponse.fromJson(result.data);
      return Tuple2(response, null);
    } on DioError catch (error) {
      return Tuple2(null, _getErrorType(error));
    }
  }

  Future<Tuple2<MoviesResponse?, MovieLoadingError?>> getMoviesByTitle({required String query}) async {
    try {
      final result = await dio.get('/search/movie?api_key=$apiKey&query=$query');
      final response = MoviesResponse.fromJson(result.data);
      return Tuple2(response, null);
    } on DioError catch (error) {
      return Tuple2(null, _getErrorType(error));
    }
  }

  Future<Tuple2<MovieDetailsResponse?, MovieLoadingError?>> getMovieDetails({required String movieId}) async {
    try {
      final result = await dio.get('/movie/$movieId?api_key=$apiKey');
      final response = MovieDetailsResponse.fromJson(result.data);
      return Tuple2(response, null);
    } on DioError catch (error) {
      return Tuple2(null, _getErrorType(error));
    }
  }

  MovieLoadingError _getErrorType(DioError? error) {
    MovieLoadingError errorType = MovieLoadingError.internetError;
    // There are more efficient ways to better deal with error code/messages,
    if (error != null && error.response != null) {
      // We could get the error message from the server as well
      // but it is easy to just use local strings to avoid latency
      // and to simplify the messages translation.
      switch(error.response!.statusCode) {
        case 401:
          errorType = MovieLoadingError.unauthorizedAccess;
          break;
        case 404:
          errorType = MovieLoadingError.serverError;
          break;
      }
    }
    return errorType;
  }

}
