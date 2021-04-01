import 'dart:convert';

import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/infrastructure/movies/mappers.dart';

MoviesResponse moviesResponseFromMap(String str) => MoviesResponse.fromMap(json.decode(str));

class MoviesResponse {
  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieResponseItem> results;
  final int totalPages;
  final int totalResults;

  factory MoviesResponse.fromMap(Map<String, dynamic> json) => MoviesResponse(
    page: json["page"],
    results: List<MovieResponseItem>.from(json["results"].map((x) => MovieResponseItem.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toMap() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class MovieResponseItem {
  MovieResponseItem({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.posterPath,
    required this.video,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
    required this.originalTitle,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? posterPath;
  final bool video;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final DateTime? releaseDate;
  final double voteAverage;
  final double popularity;

  Movie getMovie() {
    return mapMovieResponseItemToMovie(this);
  }

  factory MovieResponseItem.fromMap(Map<String, dynamic> json) {
    return MovieResponseItem(
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    posterPath: json["poster_path"],
    video: json["video"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    releaseDate: DateTime.tryParse(json["release_date"]),
    voteAverage: json["vote_average"].toDouble(),
    popularity: json["popularity"].toDouble(),
  );
  }

  Map<String, dynamic> toMap() => {
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "poster_path": posterPath,
    "video": video,
    "title": title,
    "overview": overview,
    "vote_average": voteAverage,
    "popularity": popularity,
  };
}
