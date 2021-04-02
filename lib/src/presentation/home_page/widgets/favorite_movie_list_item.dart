import 'package:flutter/material.dart';
import 'package:movies/src/domain/movies/movie.dart';

class FavoriteMovieListItem extends StatelessWidget {
  final Movie movie;
  FavoriteMovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white12.withOpacity(.08),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          Hero(
            tag: movie.id,
            child: Container(
              width: 90,
              height: 96,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(movie.posterImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Center(child: Icon(Icons.movie_sharp, size: 50, color: bgColor));
                  },
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1!.copyWith(
                    color: Colors.white
                  )),

                  Text(movie.getFormattedReleaseDate(),
                    style: textTheme.caption!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  if (movie.hasGenres())
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        movie.getGenresAsString(),
                        style: textTheme.caption!.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}