
import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchEvent {
  final String query;

  SearchEvent(this.query);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchEvent &&
          runtimeType == other.runtimeType &&
          query == other.query;

  @override
  int get hashCode => query.hashCode;
}

class MovieSearchBloc extends Bloc<SearchEvent, MovieSearchState> {
  final MoviesRepository moviesRepository;

  MovieSearchBloc({
    required this.moviesRepository,
  }) : super(MovieSearchState.initialState());

  @override
  Stream<MovieSearchState> mapEventToState(SearchEvent event) async* {
    yield state.copyWith(error: null);

    if (event.query.trim().isEmpty || event.query == state.previousQuery) {
      yield state.copyWith(previousQuery: event.query);
      return;
    }

    yield state.copyWith(
      isLoadingMovies: true,
      previousQuery: event.query,
    );

    final data = await moviesRepository.searchMoviesByTitle(query: event.query);

    emit(state.copyWith(
      isLoadingMovies: false,
      movies: data.item1,
      error: data.item2,
    ));
  }

  @override
  Stream<Transition<SearchEvent, MovieSearchState>> transformEvents(
      Stream<SearchEvent> events,
      Stream<Transition<SearchEvent, MovieSearchState>> Function (SearchEvent) transitionFn) {

    final debouncedStream = (events).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(debouncedStream, transitionFn);
  }

}

class MovieSearchState {
  final MovieLoadingError? error;
  final List<Movie> movies;
  final bool isLoadingMovies;
  final String previousQuery;

  MovieSearchState({
    required this.error,
    required this.movies,
    required this.previousQuery,
    required this.isLoadingMovies,
  });

  factory MovieSearchState.initialState() {
    return MovieSearchState(
      isLoadingMovies: false,
      previousQuery: '',
      error: null,
      movies: [],
    );
  }

  bool get hasSearch => previousQuery.isNotEmpty;

  bool get hasNoSearchResults => movies.isEmpty && hasSearch;
  bool get hasError => error != null;

  MovieSearchState copyWith({
    MovieLoadingError? error,
    List<Movie>? movies,
    bool? isLoadingMovies,
    String? previousQuery,
  }) {
    return MovieSearchState(
      movies: movies ?? this.movies,
      error: error ?? this.error,
      previousQuery: previousQuery ?? this.previousQuery,
      isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MovieSearchState &&
              runtimeType == other.runtimeType &&
              error == other.error &&
              movies == other.movies &&
              previousQuery == other.previousQuery &&
              isLoadingMovies == other.isLoadingMovies;

  @override
  int get hashCode =>
      error.hashCode ^
      previousQuery.hashCode ^
      movies.hashCode ^
      isLoadingMovies.hashCode;
}