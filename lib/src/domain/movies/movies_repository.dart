
import 'package:movies/src/domain/movies/movie_details.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';
import 'package:movies/src/infrastructure/movies/local_movies_datasource.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';
import 'package:tuple/tuple.dart';

import 'movie.dart';


abstract class MoviesRepository {
  MoviesService moviesService;
  MoviesLocalDatasource moviesLocalDatasource;

  MoviesRepository(this.moviesService, this.moviesLocalDatasource);

  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMovies({required int page});

  Stream<List<Movie>> watchFavoriteMovies();

  Future<void> updateMovie(Movie movie);

  Future<Tuple2<MovieDetails?, MovieLoadingError?>> getMovieDetails({required String movieId});

  Future<Tuple2<List<Movie>?, MovieLoadingError?>> searchMoviesByTitle({required String query});
}