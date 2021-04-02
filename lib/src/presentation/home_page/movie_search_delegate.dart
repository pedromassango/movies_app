
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/movies/movie_search_cubit.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/presentation/home_page/widgets/movie_list_item.dart';
import 'package:movies/src/presentation/movie_details_page/movie_details_page.dart';

class MovieSearchDelegate extends SearchDelegate {
  MovieSearchDelegate({ required this.movieSearchBloc}): super(
    searchFieldLabel: 'Search a Movie',
  );

  final MovieSearchBloc movieSearchBloc;

  String _getErrorMessage(MovieLoadingError error) {
    switch(error) {
      case MovieLoadingError.internetError:
        return 'Please verify your internet and try again!';
      case MovieLoadingError.serverError:
      case MovieLoadingError.unauthorizedAccess:
      case MovieLoadingError.resourceNotFound:
        return 'There was a server problem. Please try again';
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: BackButton(),
      onPressed: () => close(context, null),
    );
  }

  Widget _buildInfoLayout(Widget child) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: child,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    movieSearchBloc.add(SearchEvent(query));

    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        alignment: Alignment.topCenter,
        child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
          bloc: movieSearchBloc,
          builder: (context, state) {
            if (state.isLoadingMovies)
              return _buildInfoLayout(CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ));
            if (state.hasError)
              return _buildInfoLayout(Text(_getErrorMessage(state.error!)));
            if (state.hasNoSearchResults)
              return _buildInfoLayout(Text('No movies with $query found!'));
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        _FadePageTransition(MovieDetailsPage(movie: movie)));
                  },
                    child: MovieListItem(movie));
              },
            );
          },
        ),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final themData = ThemeData.dark().copyWith(
      accentColor: Colors.transparent,
      primaryColor: Theme.of(context).scaffoldBackgroundColor,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white)
      )
    );
    return themData;
  }

}

/// Custom page transition while navigating to movie details page.
class _FadePageTransition extends PageRouteBuilder {
  _FadePageTransition(Widget page) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      return FadeTransition(
        opacity: animation,
        child: page,
      );
    }
  );

}