import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/utils/list_sorting_strategy.dart';
import 'package:test/test.dart';

void main() {
  test('sort movie list by date in descending order', () {
    final unsortedMovies = <Movie>[
      _createFakeMovie(releaseDate: DateTime(2000, 1, 1)),
      _createFakeMovie(releaseDate: DateTime(2030, 4, 1)),
      _createFakeMovie(releaseDate: DateTime(2021, 3, 1)),
      _createFakeMovie(releaseDate: DateTime(2020, 2, 1)),
    ];

    // Verify that list is unsorted
    expect(unsortedMovies.first.releaseDate, equals(DateTime(2000, 1, 1)));
    expect(unsortedMovies.last.releaseDate, equals(DateTime(2020, 2, 1)));

    final sortedMovies = MovieListSortStrategy
    .sortMoviesByDateDescending(unsortedMovies);

    // Expect that the list is properly sorted
    expect(sortedMovies.first.releaseDate, DateTime(2030, 4, 1));
    expect(sortedMovies.last.releaseDate, DateTime(2000, 1, 1));
  });

  test('sort movie list by date in ascending order', () {
    final unsortedMovies = <Movie>[
      _createFakeMovie(releaseDate: DateTime(2030, 4, 1)),
      _createFakeMovie(releaseDate: DateTime(2021, 3, 1)),
      _createFakeMovie(releaseDate: DateTime(2020, 2, 1)),
      _createFakeMovie(releaseDate: DateTime(2000, 1, 1)),
    ];

    // Verify that list is unsorted
    expect(unsortedMovies.first.releaseDate, equals(DateTime(2030, 4, 1)));
    expect(unsortedMovies.last.releaseDate, equals(DateTime(2000, 1, 1)));

    final sortedMovies = MovieListSortStrategy
    .sortMoviesByDateAscending(unsortedMovies);

    // Expect that the list is properly sorted
    expect(sortedMovies.first.releaseDate, DateTime(2000, 1, 1));
    expect(sortedMovies.last.releaseDate, DateTime(2030, 4, 1));
  });

  test('sort movie list by title in ascending order', () {
    final unsortedMovies = <Movie>[
      _createFakeMovie(title: 'Justice'),
      _createFakeMovie(title: 'Banana'),
      _createFakeMovie(title: 'Combridge'),
      _createFakeMovie(title: 'Monster'),
    ];

    // Verify that list is unsorted
    expect(unsortedMovies.first.title, equals('Justice'));

    final sortedMovies = MovieListSortStrategy
    .sortMoviesByNameAscending(unsortedMovies);

    // Expect that the list is properly sorted
    expect(sortedMovies.first.title, 'Banana');
  });

  test('sort movie list by title in descending order', () {
    final unsortedMovies = <Movie>[
      _createFakeMovie(title: 'Banana'),
      _createFakeMovie(title: 'Justice'),
      _createFakeMovie(title: 'Combridge'),
      _createFakeMovie(title: 'Zack Snyder JL'),
    ];

    // Verify that list is unsorted
    expect(unsortedMovies.first.title, equals('Banana'));

    final sortedMovies = MovieListSortStrategy
    .sortMoviesByNameDescending(unsortedMovies);

    // Expect that the list is properly sorted
    expect(sortedMovies.first.title, 'Zack Snyder JL');
  });
}

Movie _createFakeMovie({DateTime? releaseDate, String title = ''}) {
  final effectiveReleaseDate = releaseDate ?? DateTime.now();
  return Movie(
    id: effectiveReleaseDate.toIso8601String(),
    title: title,
    overview: '',
    isFavorite: false,
    posterImageUrl: '',
    backdropImageUrl: '',
    rating: 0.0,
    releaseDate: effectiveReleaseDate,
    genresAsString: '',
    genres: [],
  );
}