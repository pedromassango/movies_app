import 'movie.dart';

class PagedMoviesResult {
  final int currentPage;
  final int maxPage;
  final List<Movie>? movies;

  PagedMoviesResult({
    required this.currentPage,
    required this.maxPage,
    required this.movies,
  });

  bool get hasMovies => movies != null && movies!.length != 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagedMoviesResult &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          maxPage == other.maxPage &&
          movies == other.movies;

  @override
  int get hashCode => currentPage.hashCode ^ maxPage.hashCode ^ movies.hashCode;
}