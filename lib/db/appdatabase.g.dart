// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $Floorappdatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$appdatabaseBuilder databaseBuilder(String name) =>
      _$appdatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$appdatabaseBuilder inMemoryDatabaseBuilder() =>
      _$appdatabaseBuilder(null);
}

class _$appdatabaseBuilder {
  _$appdatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$appdatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$appdatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<appdatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$appdatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$appdatabase extends appdatabase {
  _$appdatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WeatherHolderDao? _weatherHolderDaoInstance;

  FavoritesDao? _favoritessDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WeatherHolder` (`id` INTEGER NOT NULL, `data` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favorites` (`id` INTEGER, `lat` REAL, `long` REAL, `name` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WeatherHolderDao get weatherHolderDao {
    return _weatherHolderDaoInstance ??=
        _$WeatherHolderDao(database, changeListener);
  }

  @override
  FavoritesDao get favoritessDao {
    return _favoritessDaoInstance ??= _$FavoritesDao(database, changeListener);
  }
}

class _$WeatherHolderDao extends WeatherHolderDao {
  _$WeatherHolderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _weatherHolderInsertionAdapter = InsertionAdapter(
            database,
            'WeatherHolder',
            (WeatherHolder item) =>
                <String, Object?>{'id': item.id, 'data': item.data});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherHolder> _weatherHolderInsertionAdapter;

  @override
  Future<WeatherHolder?> getWeather() async {
    return _queryAdapter.query('SELECT * FROM WeatherHolder',
        mapper: (Map<String, Object?> row) =>
            WeatherHolder(id: row['id'] as int, data: row['data'] as String?));
  }

  @override
  Future<void> imsertWeather(WeatherHolder weatherHolder) async {
    await _weatherHolderInsertionAdapter.insert(
        weatherHolder, OnConflictStrategy.abort);
  }
}

class _$FavoritesDao extends FavoritesDao {
  _$FavoritesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoritesInsertionAdapter = InsertionAdapter(
            database,
            'Favorites',
            (Favorites item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'long': item.long,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favorites> _favoritesInsertionAdapter;

  @override
  Future<List<Favorites>> getFavorites() async {
    return _queryAdapter.queryList('SELECT *  FROM Favorites',
        mapper: (Map<String, Object?> row) => Favorites(
            id: row['id'] as int?,
            lat: row['lat'] as double?,
            long: row['long'] as double?,
            name: row['name'] as String?));
  }

  @override
  Future<void> insertFavorite(Favorites favorites) async {
    await _favoritesInsertionAdapter.insert(
        favorites, OnConflictStrategy.abort);
  }
}
