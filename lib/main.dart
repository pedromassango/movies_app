import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/api_configs.dart';
import 'package:movies/src/application/movies/movies_cubit.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';
import 'package:movies/src/infrastructure/http_client/dio_builder.dart';

import 'src/application/movies/favorite_movies/favorite_movies_cubit.dart';
import 'src/application/movies/movie_details_cubit.dart';
import 'src/presentation/home_page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final Dio dio = DioBuilder(
      baseUrl: MOVIE_DB_BASE_URL,
  ).build();

  DependencyInjection.setup(dio: dio);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MoviesRepository getMoviesRepository() {
    return getIt.get<MoviesRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MoviesCubit(moviesRepository: getMoviesRepository()),),
        BlocProvider(create: (_) => FavoriteMoviesCubit(moviesRepository: getMoviesRepository()),),
        BlocProvider(create: (_) => MovieDetailsCubit(moviesRepository: getMoviesRepository()),),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color(0xFF22272e),
        ),
        home: HomePage(),
      ),
    );
  }
}

