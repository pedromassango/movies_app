

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
    getIt.registerFactory(() => MoviesRepositoryBase(getIt.get<MoviesService>()));
  }

  static void setup({required Dio dio}) {
    if (_instance == null) {
      _instance = DependencyInjection(dio: dio);
    }
  }
}