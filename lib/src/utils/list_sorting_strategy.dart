
import 'package:movies/src/domain/movies/movie.dart';

/// Working on a external class just in case we
/// end up needing this sorting strategy in a different place.
class SortingStrategy {

  static int sortStringInAscendingOrder(String a, String b) => a.compareTo(b);
  static int sortStringInDescendingOrder(String a, String b) => b.compareTo(a);

  static int sortDateInAscendingOrder(DateTime a, DateTime b) => b.compareTo(a);
  static int sortDateInDescendingOrder(DateTime a, DateTime b) => a.compareTo(b);
}

class MovieListSortStrategy {

  static List<Movie> sortMoviesByNameAscending(List<Movie> movies) {
    return List.from(movies)..sort((Movie a, Movie b) {
      return SortingStrategy.sortStringInAscendingOrder(a.title, b.title);
    });
  }

  static List<Movie> sortMoviesByNameDescending(List<Movie> movies) {
    return List.from(movies)..sort((Movie a, Movie b) {
      return SortingStrategy.sortStringInDescendingOrder(a.title, b.title);
    });
  }

  static List<Movie> sortMoviesByDateAscending(List<Movie> movies) {
    return List.from(movies)..sort((Movie a, Movie b) {
      return SortingStrategy.sortDateInAscendingOrder(b.getReleaseDateNonNullable(), a.getReleaseDateNonNullable());
    });
  }

  static List<Movie> sortMoviesByDateDescending(List<Movie> movies) {
    return List.from(movies)..sort((Movie a, Movie b) {
      return SortingStrategy.sortDateInDescendingOrder(b.getReleaseDateNonNullable(), a.getReleaseDateNonNullable());
    });
  }
}