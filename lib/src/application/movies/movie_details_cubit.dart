import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_details.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit({
    required this.moviesRepository,
  }) : super(MovieDetailsState.initialState());

  final MoviesRepository moviesRepository;

  void loadMovieDetails(Movie movie) async {

    emit(state.copyWith(isLoadingDetails: true));

    final data = await moviesRepository.getMovieDetails(movieId: movie.id);

    emit(state.copyWith(
      isLoadingDetails: false,
      movieDetails: data.item1,
      error: data.item2,
    ));
  }

  void updateMovieState(Movie movie) {
    if (state.hasError) {
      return;
    }

    emit(state.copyWith(
      movieDetails: state.movieDetails!.copyWith(
        movie: movie,
      )
    ));
  }

  /// Since this is a global state object and this state
  /// persists when we navigate back from details page,
  /// this method is useful to clear the current movie's
  /// information right before navigating back from the
  /// movie details page.
  void resetState() {
    emit(MovieDetailsState.initialState());
  }

}

class MovieDetailsState {
  final MovieLoadingError? error;
  final MovieDetails? movieDetails;
  final bool isLoadingDetails;

  MovieDetailsState({
    required this.error,
    required this.movieDetails,
    required this.isLoadingDetails,
  });

  factory MovieDetailsState.initialState() {
    return MovieDetailsState(
      movieDetails: null,
      isLoadingDetails: false,
      error: null,
    );
  }

  bool get hasData => movieDetails != null;
  bool get hasCompanies => hasData && movieDetails!.companies.isNotEmpty;
  bool get hasError => error != null;

  MovieDetailsState copyWith({
    MovieDetails? movieDetails,
    MovieLoadingError? error,
    bool? isLoadingDetails,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      error: error ?? this.error,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsState &&
          runtimeType == other.runtimeType &&
          movieDetails == other.movieDetails &&
          error == other.error &&
          isLoadingDetails == other.isLoadingDetails;

  @override
  int get hashCode =>
      movieDetails.hashCode ^
      error.hashCode ^
      isLoadingDetails.hashCode;
}
