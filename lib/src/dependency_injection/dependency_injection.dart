

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/infrastructure/movies/local_movies_datasource.dart';
import 'package:movies/src/infrastructure/movies/movies_database/movies_database.dart';
import 'package:movies/src/infrastructure/movies/movies_repository_base.dart';
import 'package:movies/src/infrastructure/movies/movies_service.dart';


/// For global access
/// This is just a naming convection to prevent
/// spread the <get_it> package around the project.
/// So instead we make reference to this variable.
final getIt = GetIt.instance;

DependencyInjection? _instance;

class DependencyInjection {
  final Dio dio;

  DependencyInjection({required this.dio}) {
    registerServices();
    registerRepositories();
  }

  void registerServices() {
    getIt.registerFactory<MoviesService>(() => MoviesService(dio: dio));
  }

  void registerRepositories() {
    final moviesDatabase = MoviesDatabase();
    final moviesLocalDatasource = MoviesLocalDatasource(moviesDatabase);
    getIt.registerFactory<MoviesRepository>(
      () => MoviesRepositoryBase(
        getIt.get<MoviesService>(),
        moviesLocalDatasource,
      ),
    );
  }

  static void setup({required Dio dio}) {
    if (_instance == null) {
      _instance = DependencyInjection(dio: dio);
    }
  }
}