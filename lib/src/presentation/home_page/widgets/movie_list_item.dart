

import 'package:flutter/material.dart';
import 'package:movies/src/domain/movies/movie.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  MovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final double height = 180;
    final double cardPaddingTop = height * .75;

    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: cardPaddingTop,
            decoration: BoxDecoration(
                color: Colors.white12.withOpacity(.08),
                borderRadius: BorderRadius.circular(8)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: height * .6,
                  height: height * .9,
                  margin: const EdgeInsets.only(right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        onError: (_, __) => Center(child: Icon(Icons.play_arrow, size: 50),),
                        image: NetworkImage(movie.backdropImageUrl),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: cardPaddingTop / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textTheme.bodyText1!.copyWith(
                        color: Colors.white
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12, top: 4),
                        child: Row(
                          children: List.generate(10, (index) {
                            final isInRange = index <= movie.rating;
                            return Icon(Icons.star,
                              color: isInRange ? Colors.yellow : Colors.white24,
                              size: 8.5,
                            );
                          }),
                        ),
                      ),
                      if (movie.hasGenres())
                        Text(
                          movie.getMinimumGenres().join(' / '),
                          style: textTheme.caption!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      Text(movie.getReleaseDate(),
                          style: textTheme.caption!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}