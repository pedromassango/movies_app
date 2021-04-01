import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  FavoriteMoviesCubit({
    required this.moviesRepository,
  }) : super(FavoriteMoviesState.initialState());

  final MoviesRepository moviesRepository;

  void loadFavoriteMovies() async {
    /// Loading movies may take a while so
    /// we need to make sure the UI is in a
    /// loading state while doing the heavy operation
    /// of loading movies from the local database.
    emit(state.copyWith(isLoadingMovies: true));

    final movies = await moviesRepository.getFavoriteMovies();

    emit(state.copyWith(
      isLoadingMovies: false,
      movies: movies,
    ));
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