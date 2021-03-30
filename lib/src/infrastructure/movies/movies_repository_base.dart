import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';

class MoviesRepositoryBase extends MoviesRepository {
  MoviesRepositoryBase(MoviesService moviesService) : super(moviesService);

}
