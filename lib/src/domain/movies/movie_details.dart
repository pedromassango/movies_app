
class MovieDetails {
  final String id;
  final bool video;
  final String title;
  final String overview;
  final int popularity;
  final String backdropImageUrl;
  final DateTime releaseDate;

  MovieDetails({
    required this.id,
    required this.video,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.backdropImageUrl,
    required this.releaseDate,
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
          popularity == other.popularity &&
          backdropImageUrl == other.backdropImageUrl &&
          releaseDate == other.releaseDate;

  @override
  int get hashCode =>
      id.hashCode ^
      video.hashCode ^
      title.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      backdropImageUrl.hashCode ^
      releaseDate.hashCode;
}
