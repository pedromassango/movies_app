
import 'package:intl/intl.dart';
import 'package:movies/src/domain/movies/genre.dart';

class Movie {
  final String id;
  final String title;
  final String overview;
  final String posterImageUrl;
  final String backdropImageUrl;
  final List<Genre> genres;
  final double rating;
  final DateTime? releaseDate;
  final String? genresAsString;
  final bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterImageUrl,
    required this.backdropImageUrl,
    required this.genres,
    required this.rating,
    required this.releaseDate,
    required this.isFavorite,
    this.genresAsString
  });

  Movie copyWith({bool? isFavorite}) {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterImageUrl: posterImageUrl,
      backdropImageUrl: backdropImageUrl,
      genres: genres,
      rating: rating,
      releaseDate: releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
      genresAsString: genresAsString,
    );
  }

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

  bool hasGenres() => genres.isNotEmpty || genresAsString != null;

  /// Simplifying the access to
  /// display genres as a single string.
  String getGenresAsString() {
    if (genresAsString != null && genresAsString!.isNotEmpty)
      return genresAsString!;
    if (_getMinimumGenres().isEmpty)
      return 'N/A';
    return _getMinimumGenres().join(' / ');
  }

  List<Genre> _getMinimumGenres() {
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
          genresAsString == other.genresAsString &&
          releaseDate == other.releaseDate &&
          isFavorite == other.isFavorite &&
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
      isFavorite.hashCode^
      genresAsString.hashCode^
      overview.hashCode^
      rating.hashCode;
}