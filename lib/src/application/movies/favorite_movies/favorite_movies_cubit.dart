import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  FavoriteMoviesCubit({
    required this.moviesRepository,
  }) : super(FavoriteMoviesState.initialState());

  final MoviesRepository moviesRepository;

  void subscribeToFavoriteMoviesList() async {
    moviesRepository.watchFavoriteMovies().listen((movies) {
      emit(state.copyWith(
        isLoadingMovies: false,
        movies: movies,
      ));
    });
  }

  /// Since we are changing local database only
  /// there is no need to make this an async task,
  /// as we are sure that the task will complete
  /// successfully.
  Movie changeFavoriteStatus(Movie movie) {
    final updatedMovie = movie.copyWith(isFavorite: !movie.isFavorite);
    moviesRepository.updateMovie(updatedMovie);
    return updatedMovie;
  }
}

class FavoriteMoviesState {
  final List<Movie> movies;
  final bool isLoadingMovies;

  FavoriteMoviesState({
    required this.movies,
    required this.isLoadingMovies,
  });

  factory FavoriteMoviesState.initialState() {
    return FavoriteMoviesState(
      isLoadingMovies: false,
      movies: [],
    );
  }

  bool get hasMovies => movies.isNotEmpty;

  FavoriteMoviesState copyWith({
    List<Movie>? movies,
    bool? isLoadingMovies,
  }) {
    return FavoriteMoviesState(
      movies: movies ?? this.movies,
      isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavoriteMoviesState &&
              runtimeType == other.runtimeType &&
              isLoadingMovies == other.isLoadingMovies &&
              movies == other.movies;

  @override
  int get hashCode => movies.hashCode ^ isLoadingMovies.hashCode;
}