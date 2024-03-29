import 'dart:async';

import 'package:core/common/encrypt.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_series_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'watchlistMovie';
  static const String _tblMovieCache = 'cacheMovie';
  static const String _tblTVSeriesWatchlist = 'watchlistTVSeries';
  static const String _tblTVSeriesCache = 'cacheTVSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('password'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblTVSeriesWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblMovieCache (
        id INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        idMovieCache INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblTVSeriesCache (
        id INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        idTVSeriesCache INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> insertTVSeriesWatchlist(TVSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblTVSeriesWatchlist, tvSeries.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeTVSeriesWatchlist(TVSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblTVSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTVSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTVSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTVSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblTVSeriesWatchlist);

    return results;
  }

  Future<void> insertMovieCacheTransaction(
    List<MovieTable> movies, String category
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for(final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblMovieCache, movieJson);
      }
    });
  }

   Future<void> insertTVSeriesCacheTransaction(
    List<TVSeriesTable> tvs, String category
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for(final tv in tvs) {
        final tvjson = tv.toJson();
        tvjson['category'] = category;
        txn.insert(_tblTVSeriesCache, tvjson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getMovieCache(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblMovieCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<List<Map<String, dynamic>>> getTVSeriesCache(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblTVSeriesCache,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearMovieCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblMovieCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> clearTVSeriesCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblTVSeriesCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}
