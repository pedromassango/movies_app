import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class FavoriteMoviesState {}

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  FavoriteMoviesCubit({
    required FavoriteMoviesState initialState,
    required this.moviesRepository,
  }) : super(initialState);

  final MoviesRepository moviesRepository;
}
