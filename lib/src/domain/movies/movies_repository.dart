
import 'package:movies/src/infrastructure/movies/movies_service.dart';

abstract class MoviesRepository {
  MoviesService moviesService;

  MoviesRepository(this.moviesService);

  //TODO(pedromassango): add required methods
}