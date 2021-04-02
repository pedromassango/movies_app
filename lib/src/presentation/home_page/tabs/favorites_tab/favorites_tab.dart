import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/movies/favorite_movies/favorite_movies_cubit.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/presentation/home_page/widgets/favorite_movie_list_item.dart';
import 'package:movies/src/presentation/movie_details_page/movie_details_page.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavouritesTabState createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavoritesTab>
  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  void _onItemDismissed(BuildContext context, Movie movie) {
    context.read<FavoriteMoviesCubit>().changeFavoriteStatus(movie);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text('Movie removed from favorites.',
        style: TextStyle(color: Colors.black),)),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteMoviesCubit>().subscribeToFavoriteMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState>(
      builder: (context, state) {
        if (!state.hasMovies)
          return Center(child: _EmptyState());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
              child: Text('Here is a list of what you love', style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white54,
              ),),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];

                  return Dismissible(
                    key: ObjectKey(movie),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _onItemDismissed(context, movie),
                    background: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 32),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => MovieDetailsPage(movie: movie)
                        ));
                      },
                        child: FavoriteMovieListItem(movie)),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 160,
      child: Column(
        children: [
          Icon(Icons.cloud,
            color: Colors.white12,
            size: 120,
          ),
          Text('No favorites yet!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white70,
              fontSize: 16
            ),
          ),
        ],
      ),
    );
  }
}
