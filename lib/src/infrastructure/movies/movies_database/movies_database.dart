import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'movies_database.g.dart';


/// In a large codebase I would create DAOs
/// for each DTOs, but since we have only one
/// object to store and for the sake of
/// demonstration, I making this in the database
/// class itself.
@UseMoor(tables: [MovieTable])
class MoviesDatabase extends _$MoviesDatabase {
  MoviesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<MovieDatabaseObject>> watchFavoriteMovies() {
    return (select(movieTable)
      ..where((tbl) => tbl.isFavorite.isIn([true])))
        .watch();
  }

  Future<MovieDatabaseObject?> getMovieById(String id) {
    return (select(movieTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertOrUpdate(MovieDatabaseObject object) async {
    await into(movieTable).insertOnConflictUpdate(object);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final databaseFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(databaseFolder.path, 'database.sqlite'));
    return VmDatabase(file);
  });
}

@DataClassName('MovieDatabaseObject')
class MovieTable extends Table {

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get posterImageUrl => text()();
  TextColumn get backdropImageUrl => text()();
  IntColumn get rating => integer()();
  DateTimeColumn get releaseDate => dateTime()();
  TextColumn get genresAsString => text()();
  BoolColumn get isFavorite => boolean()();

  @override
  Set<Column>? get primaryKey => {id};
}
