
class Movie {
  final String id;
  final String title;
  final String posterImageUrl;
  final String backdropImageUrl;

  Movie({
    required this.id,
    required this.title,
    required this.posterImageUrl,
    required this.backdropImageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          posterImageUrl == other.posterImageUrl &&
          backdropImageUrl == other.backdropImageUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      posterImageUrl.hashCode ^
      backdropImageUrl.hashCode;
}