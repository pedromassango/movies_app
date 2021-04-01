import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/src/application/movies/movie_details_cubit.dart';
import 'package:movies/src/dependency_injection/dependency_injection.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_details.dart';
import 'package:movies/src/domain/movies/movies_repository.dart';

class MovieDetailsPage extends StatefulWidget {

  MovieDetailsPage({required this.movie});

  final Movie movie;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late final MovieDetailsCubit _movieDetailsCubit = MovieDetailsCubit(
      moviesRepository: getIt.get<MoviesRepository>(),
  );

  @override
  void initState() {
    super.initState();
    _movieDetailsCubit.loadMovieDetails(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * .55;
    final textTheme = Theme.of(context).textTheme.copyWith(
      headline6: TextStyle(color: Colors.white)
    );
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: widget.movie.id,
            child: Container(
              width: size.width,
              height: imageHeight,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [.1, .4, .55],
                  colors: [
                    bgColor.withOpacity(1),
                    bgColor.withOpacity(.7),
                    bgColor.withOpacity(.2),
                  ]
                ),
              ),
              child: Image.network(widget.movie.posterImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(child: Icon(Icons.movie_sharp, size: 50, color: Colors.white70),),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: size.width,
              height: imageHeight * .81,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: imageHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 54),
                          child: Text(widget.movie.title, style: textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 24),
                          child: Text(widget.movie.getFormattedReleaseDate(),
                            style: textTheme.headline6!.copyWith(
                                color: Colors.white60,
                                fontWeight: FontWeight.w800,
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                                bloc: _movieDetailsCubit,
                                builder: (context, state) {
                                  final status = state.hasData ? state.movieDetails!.status : 'Loading...';
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: _Section(
                                      header: 'Status',
                                      horizontalAlignment: CrossAxisAlignment.center,
                                      child: Text(status),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                                bloc: _movieDetailsCubit,
                                builder: (context, state) {
                                  final voteAverage = state.hasData ? state.movieDetails!.voteAverage : 0.0;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: _Section(
                                      header: 'Popularity',
                                      horizontalAlignment: CrossAxisAlignment.center,
                                      child: Text('$voteAverage'),
                                    ),
                                  );
                                },
                              ),
                              if (widget.movie.hasGenres())
                                _Section(
                                  header: 'Genres',
                                  horizontalAlignment: CrossAxisAlignment.center,
                                  child: Text(widget.movie.getMinimumGenres().join(' / ')),
                                ),
                            ],
                          ),
                        ),
                        _Section(
                          header: 'Overview',
                          child: Text(widget.movie.overview),
                        ),
                        BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                          bloc: _movieDetailsCubit,
                          builder: (context, state) {
                            if (!state.hasData || !state.hasCompanies)
                              return SizedBox.shrink();
                            return _CompaniesSection(state.movieDetails!.companies);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: imageHeight * .98,
            right: 16,
            child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
              bloc: _movieDetailsCubit,
              builder: (context, state) {
                if (!state.hasData)
                  return SizedBox.shrink();

                return MenuButton();
              },
            ),
          )
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.more_horiz_sharp,
          color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class _CompaniesSection extends StatelessWidget {
  final List<ProductionCompany> companies;

  const _CompaniesSection(this.companies);

  @override
  Widget build(BuildContext context) {
    return _Section(header: 'Companies',
        child: SizedBox(
          height: 80,
          child: ListView.builder(
            itemCount: companies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = companies[index];
              return Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.network(item.logoImageUrl,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image_rounded),
                ),
              );
            },
          ),
        ),
    );
  }
}

class _Section extends StatelessWidget {
  final String header;
  final Widget child;
  final CrossAxisAlignment horizontalAlignment;

  const _Section({
    required this.header,
    required this.child,
    this.horizontalAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.copyWith(
        headline6: TextStyle(color: Colors.white)
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: horizontalAlignment,
        children: [
          Text(header,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: DefaultTextStyle(
              style: textTheme.headline6!.copyWith(
                  color: Colors.white60,
              ),
                child: child,
            ),
          ),
        ],
      ),
    );
  }
}
