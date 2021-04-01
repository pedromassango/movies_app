
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';
import 'package:tuple/tuple.dart';

import 'movie.dart';


abstract class MoviesRepository {
  MoviesService moviesService;

  MoviesRepository(this.moviesService);

  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMovies({required int page});

  Future<Tuple2<List<Movie>?, MovieLoadingError?>> searchMoviesByTitle({required String query});
}