
import 'package:movies/api_configs.dart';
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/domain/movies/movie_details.dart';
import 'package:movies/src/infrastructure/movies/movie_genres_constants.dart';
import 'package:movies/src/infrastructure/movies/reponse_objects/movie_details_response.dart';
import 'package:movies/src/infrastructure/movies/reponse_objects/movies_response.dart';

/// A more practical way is to have all those converters into their own
/// classes, for example, [mapMovieResponseItemToMovie] could be
/// added into [MovieResponseItem] class.

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

MovieDetails mapMovieDetailsResponseItemToMovieDetails(MovieDetailsResponse movieDetailsResponse, {required bool isFavorite}) {
  final companies = movieDetailsResponse.productionCompanies.map((company) {
    return ProductionCompany(
      id: company.id,
      name: company.name ?? '',
      logoImageUrl: IMAGE_URL + (company.logoPath ?? ''),
      originCountry: company.originCountry ?? '',
    );
  }).toList();

  return MovieDetails(
    id: movieDetailsResponse.id.toString(),
    status: movieDetailsResponse.status ?? 'N/A',
    overview: movieDetailsResponse.overview ?? 'N/A',
    title: movieDetailsResponse.title ?? movieDetailsResponse.originalTitle ?? 'N/A',
    voteAverage: movieDetailsResponse.voteAverage ?? 0.0,
    releaseDate: movieDetailsResponse.releaseDate,
    backdropImageUrl: IMAGE_URL + (movieDetailsResponse.backdropPath ?? ''),
    isFavorite: isFavorite,
    video: movieDetailsResponse.video,
    companies: companies,
  );
}
