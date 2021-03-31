import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';
import 'package:tuple/tuple.dart';

class MoviesRepositoryBase extends MoviesRepository {
  MoviesRepositoryBase(MoviesService moviesService) : super(moviesService);

  @override
  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMovies({required int page}) async {
    //TODO(pedromassango): Implement offline-first strategy
    //TODO(pedromassango): 1- Load data from local database first

    final result = await getMoviesFromService();
    if (result.item1 != null) {
      //TODO(pedromassango): save data locally
      return result;
    }
    return Tuple2<PagedMoviesResult?, MovieLoadingError?>(null, result.item2);
  }

  Future<Tuple2<PagedMoviesResult?, MovieLoadingError?>> getMoviesFromService([int page = 0]) async {
    //TODO(pedromassango): Implement offline-first strategy
    //TODO(pedromassango): 1- Load data from local database

    final result = await moviesService.getMovies(page: page);
    if (result.item1 != null) {
      final response = result.item1!;
      final pagedResult = PagedMoviesResult(
        movies: response.results.map<Movie>((item) => item.getMovie()).toList(),
          currentPage: response.page,
        maxPage: response.totalPages,
      );
      return Tuple2<PagedMoviesResult?, MovieLoadingError?>(pagedResult, null);
    }
    return Tuple2<PagedMoviesResult?, MovieLoadingError?>(null, result.item2);
  }

}
