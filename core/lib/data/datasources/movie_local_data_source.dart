import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/utils/exception.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<void> cachePopularMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedPopularMovies();
  Future<void> cacheTopRatedMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedTopRatedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMovieCache('now_playing');
    await databaseHelper.insertMovieCacheTransaction(movies, 'now_playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getMovieCache('now_playing');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMovieCache('popular');
    await databaseHelper.insertMovieCacheTransaction(movies, 'popular');
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    final result = await databaseHelper.getMovieCache('popular');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async {
    await databaseHelper.clearMovieCache('top_rated');
    await databaseHelper.insertMovieCacheTransaction(movies, 'top_rated');
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    final result = await databaseHelper.getMovieCache('top_rated');
    if (result.isNotEmpty) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
