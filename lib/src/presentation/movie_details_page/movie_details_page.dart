import 'package:flutter/material.dart';
import 'package:movies/src/domain/movies/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * .55;
    final textTheme = Theme.of(context).textTheme.copyWith(
      headline6: TextStyle(color: Colors.white)
    );
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: movie.id,
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
              child: Image.network(movie.posterImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(child: Icon(Icons.movie_sharp, size: 50, color: Colors.white70),),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: imageHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900
                ),),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 32),
                  child: Text(movie.getFormattedReleaseDate(),
                    style: textTheme.headline6!.copyWith(
                        color: Colors.white60,
                        fontWeight: FontWeight.w800
                  ),
                  ),
                ),
                if (movie.hasGenres())
                  _Section(
                    header: 'Genres',
                    child: Text(movie.getMinimumGenres().join(' / ')),
                  ),
                _Section(
                  header: 'Overview',
                  child: Text(movie.overview),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String header;
  final Widget child;

  const _Section({required this.header, required this.child});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.copyWith(
        headline6: TextStyle(color: Colors.white)
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),),
          DefaultTextStyle(
            style: textTheme.headline6!.copyWith(
                color: Colors.white60,
            ),
              child: child,
          ),
        ],
      ),
    );
  }
}
