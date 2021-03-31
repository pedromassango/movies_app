import 'package:bloc/bloc.dart';
import 'package:movies/src/application/cubit_state.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class FavoriteMoviesCubit extends Cubit<CubitState<List<Movie>, FavoriteMoviesLoadingResult>> {
  FavoriteMoviesCubit({
    required this.moviesRepository,
  }) : super(CubitState.initialState());

  final MoviesRepository moviesRepository;
}

enum FavoriteMoviesLoadingResult { noData }