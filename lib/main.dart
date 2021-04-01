import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies/api_configs.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/infrastructure/http_client/dio_builder.dart';

import 'src/presentation/home_page/home_page.dart';

void main() {

  final Dio dio = DioBuilder(
      baseUrl: MOVIE_DB_BASE_URL,
  ).build();

  DependencyInjection.setup(dio: dio);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFF22272e),
    ),
      home: HomePage(),
    );
  }
}

