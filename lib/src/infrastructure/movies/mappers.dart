
import 'package:movies/api_configs.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/infrastructure/movies/movie_genres_constants.dart';
import 'package:movies/src/infrastructure/movies/reponse_objects/movies_response.dart';

Movie mapMovieResponseItemToMovie(MovieResponseItem movieResponseItem) {
  return Movie(
    id: movieResponseItem.id.toString(),
    overview: movieResponseItem.overview ?? 'N/A',
    title: movieResponseItem.title ?? movieResponseItem.originalTitle ?? 'N/A',
    rating: movieResponseItem.voteAverage.round(),
    genres: getGenresBy(movieResponseItem.genreIds),
    releaseDate: movieResponseItem.releaseDate,
    backdropImageUrl: IMAGE_URL + (movieResponseItem.backdropPath ?? ''),
    posterImageUrl: IMAGE_URL + (movieResponseItem.posterPath ?? ''),
  );
}

