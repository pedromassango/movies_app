import 'dart:convert';

MovieDetailsResponse movieDetailsResponseFromJson(String str) => MovieDetailsResponse.fromJson(json.decode(str));

String movieDetailsResponseToJson(MovieDetailsResponse data) => json.encode(data.toJson());

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
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    required this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final String homepage;
  final int id;
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
  final List<SpokenLanguage>? spokenLanguages;
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
    spokenLanguages: List<SpokenLanguage>.from(json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection,
    "budget": budget,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "revenue": revenue,
    "runtime": runtime,
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath == null ? null : logoPath,
    "name": name,
    "origin_country": originCountry,
  };
}

class SpokenLanguage {
  SpokenLanguage({
    this.iso6391,
    required this.name,
  });

  String? iso6391;
  final String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391,
    "name": name,
  };
}
