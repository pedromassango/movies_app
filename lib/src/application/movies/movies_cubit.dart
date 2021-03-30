import 'package:bloc/bloc.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class MoviesState {}

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({
    required MoviesState initialState,
    required this.moviesRepository,
  }) : super(initialState);

  final MoviesRepository moviesRepository;
}
