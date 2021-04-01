
import 'package:movies/src/domain/movies/movie.dart';
import 'package:movies/src/infrastructure/movies/movies_database/movies_database.dart';

/// I would create an abstraction for this class
/// to make it easy to change the database later.
class MoviesLocalDatasource {
  final MoviesDatabase database;

  MoviesLocalDatasource(this.database);

  Future<List<Movie>> getAllMovies() async {
    final data = await database.getAllMovies();
    if (data == null) {
      return [];
    }
    return data.map<Movie>(_movieDatabaseObjectConverter).toList();
  }

  Stream<List<Movie>> watchFavoriteMovies() {
    return database.watchFavoriteMovies()
    .map<List<Movie>>((event) => event.map(_movieDatabaseObjectConverter)
        .toList());
  }

  Future<void> insertOrUpdateMovie(Movie movie) async {
    await database.insertOrUpdate(_movieConverter(movie));
  }

  Future<Movie?> getMovie(String movieId) async {
    final data = await database.getMovieById(movieId);
    if (data != null)
      return _movieDatabaseObjectConverter(data);
    return null;
  }

  Future<void> insertAllOrUpdate(List<Movie> movies) async {
    for (int i = 0; i < movies.length; i++) {
      await insertOrUpdateMovie(movies[i]);
    }
  }

}

Movie _movieDatabaseObjectConverter(MovieDatabaseObject object) {
  return Movie(
    id: object.id,
    overview: object.overview,
    title: object.title,
    rating: 0, // we are not storing rating info in database
    genres: [],
    isFavorite: object.isFavorite,
    genresAsString: object.genresAsString,
    releaseDate: object.releaseDate,
    backdropImageUrl: object.backdropImageUrl,
    posterImageUrl: object.posterImageUrl,
  );
}

MovieDatabaseObject _movieConverter(Movie movie) {
  return MovieDatabaseObject(
    id: movie.id,
    overview: movie.overview,
    title: movie.title,
    rating: 0, // we are not storing rating info in database
    isFavorite: movie.isFavorite,
    genresAsString: movie.getGenresAsString(),
    releaseDate: movie.getReleaseDateNonNullable(),
    backdropImageUrl: movie.backdropImageUrl,
    posterImageUrl: movie.posterImageUrl,
  );
}
