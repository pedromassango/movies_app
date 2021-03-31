import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/utils/list_sorting_strategy.dart';

enum SortMode { nameAsc, nameDesc, dateAsc, dateDesc }

class MoviesCubit extends Cubit<MoviesListState> {
  MoviesCubit({
    required this.moviesRepository,
  }) : super(MoviesListState.initialState());

  final MoviesRepository moviesRepository;

  void loadMovies() async {
    emit(state.copyWith(isLoadingMovies: true));

    final data = await moviesRepository.getMovies(page: 0);

    emit(state.copyWith(
      isLoadingMovies: false,
      movies: data.item1?.movies,
      currentPage: data.item1?.currentPage,
      maxPage: data.item1?.maxPage,
      error: data.item2,
    ));
  }

  void sortMovies(SortMode mode) {
    if (state.isLoadingMovies || !state.hasMovies
        || state.hasError || mode == state.sortingMode) {
      return;
    }

    emit(state.copyWith(isLoadingMovies: true));

    var movies = List<Movie>.from(state.movies);
    switch (mode) {
      case SortMode.nameAsc:
        movies = MovieListSortStrategy.sortMoviesByNameAscending(movies);
        break;
      case SortMode.dateAsc:
        movies = MovieListSortStrategy.sortMoviesByDateAscending(movies);
        break;
      case SortMode.nameDesc:
        movies = MovieListSortStrategy.sortMoviesByNameDescending(movies);
        break;
      case SortMode.dateDesc:
        movies = MovieListSortStrategy.sortMoviesByDateDescending(movies);
        break;
    }
    emit(
      state.copyWith(
        isLoadingMovies: false,
        movies: movies,
        sortingMode: mode
      ),
    );
  }
}

class MoviesListState {
  final SortMode sortingMode;
  final MovieLoadingError? error;
  final int currentPage;
  final int maxPage;
  final List<Movie> movies;
  final bool isLoadingMovies;

  MoviesListState({
    required this.sortingMode,
    required this.error,
    required this.currentPage,
    required this.maxPage,
    required this.movies,
    required this.isLoadingMovies,
  });

  factory MoviesListState.initialState() {
    return MoviesListState(
      sortingMode: SortMode.dateAsc,
      isLoadingMovies: false,
      error: null,
      currentPage: 0,
      maxPage: 1,
      movies: [],
    );
  }

  bool get hasMovies => movies.isNotEmpty;
  bool get hasError => error != null;

  MoviesListState copyWith({
    SortMode? sortingMode,
    MovieLoadingError? error,
    int? currentPage,
    int? maxPage,
    List<Movie>? movies,
    bool? isLoadingMovies,
  }) {
    return MoviesListState(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      maxPage: maxPage ?? this.maxPage,
      sortingMode: sortingMode ?? this.sortingMode,
      error: error ?? this.error,
      isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesListState &&
          runtimeType == other.runtimeType &&
          sortingMode == other.sortingMode &&
          error == other.error &&
          currentPage == other.currentPage &&
          maxPage == other.maxPage &&
          movies == other.movies &&
          isLoadingMovies == other.isLoadingMovies;

  @override
  int get hashCode =>
      sortingMode.hashCode ^
      error.hashCode ^
      currentPage.hashCode ^
      maxPage.hashCode ^
      movies.hashCode ^
      isLoadingMovies.hashCode;
}
