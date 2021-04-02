import 'movie.dart';

class MovieDetails {
  final Movie movie;
  final bool video;
  final String status;
  final List<ProductionCompany> companies;

  MovieDetails({
    required this.video,
    required this.status,
    required this.companies,
    required this.movie,
  });

  MovieDetails copyWith({Movie? movie}) {
    return MovieDetails(
      video: video,
      status: status,
      companies: companies,
      movie: movie ?? this.movie,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetails &&
          runtimeType == other.runtimeType &&
          video == other.video &&
          movie == other.movie &&
          status == other.status &&
          companies == other.companies;

  @override
  int get hashCode =>
      video.hashCode ^
      movie.hashCode ^
      status.hashCode ^
      companies.hashCode;
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
