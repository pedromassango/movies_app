import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_details.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';
import 'package:movies/src/infrastructure/movies/local_movies_datasource.dart';
import 'package:movies/src/infrastructure/movies/mappers.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';
import 'package:tuple/tuple.dart';

class MoviesRepositoryBase extends MoviesRepository {
  MoviesRepositoryBase(
      MoviesService moviesService,
      MoviesLocalDatasource moviesLocalDatasource,
      ) : super(moviesService, moviesLocalDatasource);

  @override
  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMovies({required int page}) async {
    // Here we can cache all movies into database
    // to implement a offline-first cache strategy.
    return getMoviesFromMoviesService();
  }

  @override
  Future<Tuple2<List<Movie>?, MovieLoadingError?>> searchMoviesByTitle({required String query}) async {
    final result = await moviesService.getMoviesByTitle(query: query);
    if (result.item1 != null) {
      final response = result.item1!;
      // searched movies do have the favorite state set to false
      // that is just because in the UI layer we don't need this information.
      final movies = response.results.map<Movie>((item) {
        return movieResponseItemConverter(item, isFavorite: false);
      }).toList();

      final pagedResult = PagedMoviesResult(
        movies: movies,
        currentPage: response.page,
        maxPage: response.totalPages,
      );
      return Tuple2<List<Movie>?, MovieLoadingError?>(pagedResult.movies, null);
    }
    return Tuple2(null, result.item2);
  }

  Future<bool> _isFavoriteMovie(String movieId) async {
    final databaseMovie = await moviesLocalDatasource.getMovie(movieId);
    return databaseMovie != null && databaseMovie.isFavorite;
  }

  @override
  Future<Tuple2<MovieDetails?, MovieLoadingError?>> getMovieDetails({required String movieId}) async {
    final response = await moviesService.getMovieDetails(movieId: movieId);

    if (response.item1 != null) {
      final isFavorite = await _isFavoriteMovie(movieId);

      final data = movieDetailsResponseItemConverter(
        response.item1!,
        isFavorite: isFavorite
      );
      return Tuple2<MovieDetails?, MovieLoadingError?>(data, null);
    }
    return Tuple2<MovieDetails?, MovieLoadingError?>(null, response.item2);
  }

  @override
  Stream<List<Movie>> watchFavoriteMovies() {
    return moviesLocalDatasource.watchFavoriteMovies();
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await moviesLocalDatasource.insertOrUpdateMovie(movie);
  }

  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMoviesFromMoviesService([int page = 0]) async {
    final result = await moviesService.getMovies(page: page);
    if (result.item1 != null) {
      final response = result.item1!;
      final pagedResult = PagedMoviesResult(
        movies: response.results.map<Movie>((item) {
          return movieResponseItemConverter(item, isFavorite: false);
        }).toList(),
          currentPage: response.page,
        maxPage: response.totalPages,
      );
      return Tuple2<PagedMoviesResult?, MovieLoadingError?>(pagedResult, null);
    }
    return Tuple2<PagedMoviesResult?, MovieLoadingError?>(null, result.item2);
  }

}
