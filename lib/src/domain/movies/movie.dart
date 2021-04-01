
import 'package:intl/intl.dart';
import 'package:movies/src/domain/movies/genre.dart';

class Movie {
  final String id;
  final String title;
  final String overview;
  final String posterImageUrl;
  final String backdropImageUrl;
  final List<Genre> genres;
  final int rating;
  final DateTime? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterImageUrl,
    required this.backdropImageUrl,
    required this.genres,
    required this.rating,
    required this.releaseDate,
  });

  /// Hack to provide a "reliable" (non-nullable)
  /// date to the comparator function because some Movies just does not give
  /// us the release date.
  DateTime getReleaseDateNonNullable() {
    return releaseDate ?? DateTime.now();
  }

  String getFormattedReleaseDate() {
    if (releaseDate == null) {
      return 'N/A';
    }
    return DateFormat.yMMMMd().format(releaseDate!);
  }

  bool hasGenres() => genres.isNotEmpty;

  List<Genre> getMinimumGenres() {
    late final List<Genre> _genres;
    if (this.genres.length > 2) {
      _genres = genres.sublist(0, 2);
    } else {
      _genres = genres;
    }
    return _genres;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          posterImageUrl == other.posterImageUrl &&
          backdropImageUrl == other.backdropImageUrl &&
          genres == other.genres &&
          releaseDate == other.releaseDate &&
          overview == other.overview &&
          rating == other.rating;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      posterImageUrl.hashCode ^
      backdropImageUrl.hashCode^
      genres.hashCode^
      releaseDate.hashCode^
      overview.hashCode^
      rating.hashCode;
}