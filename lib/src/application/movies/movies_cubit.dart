import 'package:bloc/bloc.dart';
import 'package:movies/src/application/cubit_state.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';


class MoviesCubit extends Cubit<CubitState<PagedMoviesResult, MovieLoadingError>> {
  MoviesCubit({
    required this.moviesRepository,
  }) : super(CubitState.initialState());

  final MoviesRepository moviesRepository;

  void loadMovies() async {
    emit(state.copyWith(isLoading: true));

    final data = await moviesRepository.getMovies(page: 0);

    emit(state.copyWith(
      isLoading: false,
      data: data.item1,
      error: data.item2,
    ));
  }
}
