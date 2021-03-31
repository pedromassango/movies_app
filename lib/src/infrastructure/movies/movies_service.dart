import 'package:dio/dio.dart';
import 'package:movies/api_configs.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/infrastructure/movies/reponse_objects/movies_response.dart';
import 'package:tuple/tuple.dart';

class MoviesService {
  final Dio dio;
  static const String apiKey = API_KEY;

  MoviesService({required this.dio});

  Future<Tuple2<MoviesResponse?, MovieLoadingError?>> getMovies({int page = 0}) async {
    try {
      final result = await dio.get('/trending/movie/day?api_key=$apiKey');
      final response = MoviesResponse.fromMap(result.data);
      return Tuple2(response, null);
    } catch (e) {
      MovieLoadingError error = MovieLoadingError.internetError;
      if (e is DioError && e.response != null) {
        switch(e.response!.statusCode) {
          case 401:
            error = MovieLoadingError.unauthorizedAccess;
            break;
          case 404:
            error = MovieLoadingError.serverError;
            break;
        }
      }
      return Tuple2(null, error);
    }
  }

}
