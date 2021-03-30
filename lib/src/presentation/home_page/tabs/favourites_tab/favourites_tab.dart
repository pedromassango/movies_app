import 'package:flutter/material.dart';
import 'package:movies/src/application/movies/favorite_movies/favorite_movies_cubit.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class FavouritesTab extends StatefulWidget {
  @override
  _FavouritesTabState createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab>
  with AutomaticKeepAliveClientMixin {

  late final FavoriteMoviesCubit _favoriteMoviesCubit = FavoriteMoviesCubit(
      initialState: FavoriteMoviesState(),
      moviesRepository: getIt.get<MoviesRepository>(),
  );

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.blue,
    );
  }
}
