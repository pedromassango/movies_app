import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/movies/movies_cubit.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/presentation/home_page/widgets/movie_list_item.dart';
import 'package:movies/src/presentation/movie_details_page/movie_details_page.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab>
  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  String getErrorMessage(MovieLoadingError error) {
    switch(error) {
      case MovieLoadingError.internetError:
        return 'Please verify your internet and try again!';
      case MovieLoadingError.serverError:
      case MovieLoadingError.unauthorizedAccess:
      case MovieLoadingError.resourceNotFound:
        return 'There was a server problem. Please try again';
    }
  }

  String getSortModeName(SortMode mode) {
    switch(mode) {
      case SortMode.nameAsc:
        return 'Sort by Name Asc';
      case SortMode.nameDesc:
        return 'Sort by Name Desc';
      case SortMode.dateAsc:
        return 'Sort by Date Asc';
      case SortMode.dateDesc:
        return 'Sort by Name Desc';
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 32, 12),
          child: Row(
            children: [
              Text('Trending', style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white54,
              ),),
              Spacer(),
              DropdownButtonHideUnderline(
                child: DropdownButton<SortMode>(
                  icon: Icon(Icons.sort_sharp, color: Colors.white54,),
                  onTap: () {},
                  onChanged: (mode) => context.read<MoviesCubit>().sortMovies(mode!),
                  items: SortMode.values.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(getSortModeName(mode)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<MoviesCubit, MoviesListState>(
            builder: (context, state) {
              if (state.isLoadingMovies)
                return Center(child: CircularProgressIndicator());
              if (state.error != null)
                return Center(child: Text(getErrorMessage(state.error!)));

              final movies = state.movies;
              if (movies.isEmpty)
                return Center(child: Text('There is no available movies!'),);
              return ListView.builder(
                itemCount: movies.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => MovieDetailsPage(movie: movie)
                      ));
                    },
                      child: MovieListItem(movie));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
