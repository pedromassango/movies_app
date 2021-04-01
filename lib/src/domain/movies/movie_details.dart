
class MovieDetails {
  final String id;
  final bool video;
  final String title;
  final String overview;
  final double voteAverage;
  final String backdropImageUrl;
  final DateTime? releaseDate;
  final bool isFavorite;
  final String status;
  final List<ProductionCompany> companies;

  MovieDetails({
    required this.id,
    required this.video,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.backdropImageUrl,
    required this.releaseDate,
    required this.isFavorite,
    required this.status,
    required this.companies,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetails &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          video == other.video &&
          title == other.title &&
          overview == other.overview &&
          voteAverage == other.voteAverage &&
          backdropImageUrl == other.backdropImageUrl &&
          isFavorite == other.isFavorite &&
          status == other.status &&
          companies == other.companies &&
          releaseDate == other.releaseDate;

  @override
  int get hashCode =>
      id.hashCode ^
      video.hashCode ^
      title.hashCode ^
      overview.hashCode ^
      voteAverage.hashCode ^
      status.hashCode ^
      isFavorite.hashCode ^
      companies.hashCode ^
      backdropImageUrl.hashCode ^
      releaseDate.hashCode;
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoImageUrl,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String logoImageUrl;
  final String name;
  final String originCountry;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductionCompany &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          logoImageUrl == other.logoImageUrl &&
          name == other.name &&
          originCountry == other.originCountry;

  @override
  int get hashCode =>
      id.hashCode ^ logoImageUrl.hashCode ^ name.hashCode ^ originCountry.hashCode;
}
