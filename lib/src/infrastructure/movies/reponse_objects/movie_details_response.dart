import 'dart:convert';

MovieDetailsResponse movieDetailsResponseFromJson(String str) => MovieDetailsResponse.fromJson(json.decode(str));

class MovieDetailsResponse {
  MovieDetailsResponse({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    required this.video,
    this.voteAverage,
    this.voteCount,
    required this.genreIds,
  });

  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final String homepage;
  final int id;
  final List<int> genreIds;
  final String imdbId;
  final String originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double popularity;
  final dynamic posterPath;
  final List<_ProductionCompany> productionCompanies;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? title;
  final bool video;
  final double? voteAverage;
  final int? voteCount;

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) => MovieDetailsResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    belongsToCollection: json["belongs_to_collection"],
    budget: json["budget"],
    homepage: json["homepage"],
    id: json["id"],
    genreIds: json["genres"] == null ? [] : List<int>.from(json["genres"].map((x) => x['id'])),
    imdbId: json["imdb_id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    productionCompanies: List<_ProductionCompany>.from(json["production_companies"].map((x) => _ProductionCompany.fromJson(x))),
    releaseDate: DateTime.parse(json["release_date"]),
    revenue: json["revenue"],
    runtime: json["runtime"],
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );
}

class _ProductionCompany {
  _ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  factory _ProductionCompany.fromJson(Map<String, dynamic> json) => _ProductionCompany(
    id: json["id"],
    logoPath: json["logo_path"] == null ? null : json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );

}
