import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/cubit_state.dart';
import 'package:movies/src/application/movies/movies_cubit.dart';
import 'package:movies/src/domain/movies/movie_loading_error.dart';
import 'package:movies/src/domain/movies/paged_movies.dart';
import 'package:movies/src/presentation/home_page/widgets/movie_list_item.dart';

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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: [
              Text('All Movies', style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white54,
              ),),
              Spacer(),
              IconButton(icon: Icon(Icons.sort, color: Colors.white54,), onPressed: () {}),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<MoviesCubit, CubitState<PagedMoviesResult, MovieLoadingError>>(
            builder: (context, state) {
              if (state.isLoading)
                return Center(child: CircularProgressIndicator());
              if (state.error != null)
                return Center(child: Text(getErrorMessage(state.error!)));

              final movies = state.data!.movies!;
              if (movies.isEmpty)
                return Center(child: Text('There is no available movies!'),);
              return ListView.builder(
                itemCount: movies.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieListItem(movie);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
