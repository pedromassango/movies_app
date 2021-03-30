import 'package:flutter/material.dart';
import 'package:movies/src/application/movies/movies_cubit.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab>
  with AutomaticKeepAliveClientMixin {

  late final MoviesCubit _moviesCubit = MoviesCubit(
    initialState: MoviesState(),
    moviesRepository: getIt.get<MoviesRepository>(),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.grey,
    );
  }
}
