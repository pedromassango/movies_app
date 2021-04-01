// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MovieDatabaseObject extends DataClass
    implements Insertable<MovieDatabaseObject> {
  final String id;
  final String title;
  final String overview;
  final String posterImageUrl;
  final String backdropImageUrl;
  final int rating;
  final DateTime releaseDate;
  final String genresAsString;
  final bool isFavorite;
  MovieDatabaseObject(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterImageUrl,
      required this.backdropImageUrl,
      required this.rating,
      required this.releaseDate,
      required this.genresAsString,
      required this.isFavorite});
  factory MovieDatabaseObject.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MovieDatabaseObject(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      overview: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}overview'])!,
      posterImageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}poster_image_url'])!,
      backdropImageUrl: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}backdrop_image_url'])!,
      rating:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}rating'])!,
      releaseDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
      genresAsString: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}genres_as_string'])!,
      isFavorite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favorite'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    map['poster_image_url'] = Variable<String>(posterImageUrl);
    map['backdrop_image_url'] = Variable<String>(backdropImageUrl);
    map['rating'] = Variable<int>(rating);
    map['release_date'] = Variable<DateTime>(releaseDate);
    map['genres_as_string'] = Variable<String>(genresAsString);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  MovieTableCompanion toCompanion(bool nullToAbsent) {
    return MovieTableCompanion(
      id: Value(id),
      title: Value(title),
      overview: Value(overview),
      posterImageUrl: Value(posterImageUrl),
      backdropImageUrl: Value(backdropImageUrl),
      rating: Value(rating),
      releaseDate: Value(releaseDate),
      genresAsString: Value(genresAsString),
      isFavorite: Value(isFavorite),
    );
  }

  factory MovieDatabaseObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MovieDatabaseObject(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterImageUrl: serializer.fromJson<String>(json['posterImageUrl']),
      backdropImageUrl: serializer.fromJson<String>(json['backdropImageUrl']),
      rating: serializer.fromJson<int>(json['rating']),
      releaseDate: serializer.fromJson<DateTime>(json['releaseDate']),
      genresAsString: serializer.fromJson<String>(json['genresAsString']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterImageUrl': serializer.toJson<String>(posterImageUrl),
      'backdropImageUrl': serializer.toJson<String>(backdropImageUrl),
      'rating': serializer.toJson<int>(rating),
      'releaseDate': serializer.toJson<DateTime>(releaseDate),
      'genresAsString': serializer.toJson<String>(genresAsString),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  MovieDatabaseObject copyWith(
          {String? id,
          String? title,
          String? overview,
          String? posterImageUrl,
          String? backdropImageUrl,
          int? rating,
          DateTime? releaseDate,
          String? genresAsString,
          bool? isFavorite}) =>
      MovieDatabaseObject(
        id: id ?? this.id,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        posterImageUrl: posterImageUrl ?? this.posterImageUrl,
        backdropImageUrl: backdropImageUrl ?? this.backdropImageUrl,
        rating: rating ?? this.rating,
        releaseDate: releaseDate ?? this.releaseDate,
        genresAsString: genresAsString ?? this.genresAsString,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('MovieDatabaseObject(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterImageUrl: $posterImageUrl, ')
          ..write('backdropImageUrl: $backdropImageUrl, ')
          ..write('rating: $rating, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('genresAsString: $genresAsString, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              overview.hashCode,
              $mrjc(
                  posterImageUrl.hashCode,
                  $mrjc(
                      backdropImageUrl.hashCode,
                      $mrjc(
                          rating.hashCode,
                          $mrjc(
                              releaseDate.hashCode,
                              $mrjc(genresAsString.hashCode,
                                  isFavorite.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MovieDatabaseObject &&
          other.id == this.id &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterImageUrl == this.posterImageUrl &&
          other.backdropImageUrl == this.backdropImageUrl &&
          other.rating == this.rating &&
          other.releaseDate == this.releaseDate &&
          other.genresAsString == this.genresAsString &&
          other.isFavorite == this.isFavorite);
}

class MovieTableCompanion extends UpdateCompanion<MovieDatabaseObject> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> overview;
  final Value<String> posterImageUrl;
  final Value<String> backdropImageUrl;
  final Value<int> rating;
  final Value<DateTime> releaseDate;
  final Value<String> genresAsString;
  final Value<bool> isFavorite;
  const MovieTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterImageUrl = const Value.absent(),
    this.backdropImageUrl = const Value.absent(),
    this.rating = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.genresAsString = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  MovieTableCompanion.insert({
    required String id,
    required String title,
    required String overview,
    required String posterImageUrl,
    required String backdropImageUrl,
    required int rating,
    required DateTime releaseDate,
    required String genresAsString,
    required bool isFavorite,
  })   : id = Value(id),
        title = Value(title),
        overview = Value(overview),
        posterImageUrl = Value(posterImageUrl),
        backdropImageUrl = Value(backdropImageUrl),
        rating = Value(rating),
        releaseDate = Value(releaseDate),
        genresAsString = Value(genresAsString),
        isFavorite = Value(isFavorite);
  static Insertable<MovieDatabaseObject> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterImageUrl,
    Expression<String>? backdropImageUrl,
    Expression<int>? rating,
    Expression<DateTime>? releaseDate,
    Expression<String>? genresAsString,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterImageUrl != null) 'poster_image_url': posterImageUrl,
      if (backdropImageUrl != null) 'backdrop_image_url': backdropImageUrl,
      if (rating != null) 'rating': rating,
      if (releaseDate != null) 'release_date': releaseDate,
      if (genresAsString != null) 'genres_as_string': genresAsString,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  MovieTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? overview,
      Value<String>? posterImageUrl,
      Value<String>? backdropImageUrl,
      Value<int>? rating,
      Value<DateTime>? releaseDate,
      Value<String>? genresAsString,
      Value<bool>? isFavorite}) {
    return MovieTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterImageUrl: posterImageUrl ?? this.posterImageUrl,
      backdropImageUrl: backdropImageUrl ?? this.backdropImageUrl,
      rating: rating ?? this.rating,
      releaseDate: releaseDate ?? this.releaseDate,
      genresAsString: genresAsString ?? this.genresAsString,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterImageUrl.present) {
      map['poster_image_url'] = Variable<String>(posterImageUrl.value);
    }
    if (backdropImageUrl.present) {
      map['backdrop_image_url'] = Variable<String>(backdropImageUrl.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (genresAsString.present) {
      map['genres_as_string'] = Variable<String>(genresAsString.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterImageUrl: $posterImageUrl, ')
          ..write('backdropImageUrl: $backdropImageUrl, ')
          ..write('rating: $rating, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('genresAsString: $genresAsString, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $MovieTableTable extends MovieTable
    with TableInfo<$MovieTableTable, MovieDatabaseObject> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MovieTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  @override
  late final GeneratedTextColumn overview = _constructOverview();
  GeneratedTextColumn _constructOverview() {
    return GeneratedTextColumn(
      'overview',
      $tableName,
      false,
    );
  }

  final VerificationMeta _posterImageUrlMeta =
      const VerificationMeta('posterImageUrl');
  @override
  late final GeneratedTextColumn posterImageUrl = _constructPosterImageUrl();
  GeneratedTextColumn _constructPosterImageUrl() {
    return GeneratedTextColumn(
      'poster_image_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _backdropImageUrlMeta =
      const VerificationMeta('backdropImageUrl');
  @override
  late final GeneratedTextColumn backdropImageUrl =
      _constructBackdropImageUrl();
  GeneratedTextColumn _constructBackdropImageUrl() {
    return GeneratedTextColumn(
      'backdrop_image_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedIntColumn rating = _constructRating();
  GeneratedIntColumn _constructRating() {
    return GeneratedIntColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedDateTimeColumn releaseDate = _constructReleaseDate();
  GeneratedDateTimeColumn _constructReleaseDate() {
    return GeneratedDateTimeColumn(
      'release_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _genresAsStringMeta =
      const VerificationMeta('genresAsString');
  @override
  late final GeneratedTextColumn genresAsString = _constructGenresAsString();
  GeneratedTextColumn _constructGenresAsString() {
    return GeneratedTextColumn(
      'genres_as_string',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedBoolColumn isFavorite = _constructIsFavorite();
  GeneratedBoolColumn _constructIsFavorite() {
    return GeneratedBoolColumn(
      'is_favorite',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        overview,
        posterImageUrl,
        backdropImageUrl,
        rating,
        releaseDate,
        genresAsString,
        isFavorite
      ];
  @override
  $MovieTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'movie_table';
  @override
  final String actualTableName = 'movie_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MovieDatabaseObject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_image_url')) {
      context.handle(
          _posterImageUrlMeta,
          posterImageUrl.isAcceptableOrUnknown(
              data['poster_image_url']!, _posterImageUrlMeta));
    } else if (isInserting) {
      context.missing(_posterImageUrlMeta);
    }
    if (data.containsKey('backdrop_image_url')) {
      context.handle(
          _backdropImageUrlMeta,
          backdropImageUrl.isAcceptableOrUnknown(
              data['backdrop_image_url']!, _backdropImageUrlMeta));
    } else if (isInserting) {
      context.missing(_backdropImageUrlMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('genres_as_string')) {
      context.handle(
          _genresAsStringMeta,
          genresAsString.isAcceptableOrUnknown(
              data['genres_as_string']!, _genresAsStringMeta));
    } else if (isInserting) {
      context.missing(_genresAsStringMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieDatabaseObject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MovieDatabaseObject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MovieTableTable createAlias(String alias) {
    return $MovieTableTable(_db, alias);
  }
}

abstract class _$MoviesDatabase extends GeneratedDatabase {
  _$MoviesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MovieTableTable movieTable = $MovieTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieTable];
}
