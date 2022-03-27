import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_series_table.dart';
import 'package:core/utils/exception.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertTVWatchlist(TVSeriesTable tvSeries);
  Future<String> removeTVWatchlist(TVSeriesTable tvSeries);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTVSeries();
  Future<void> cacheOnTheAirTVSeries(List<TVSeriesTable> tvSeries);
  Future<List<TVSeriesTable>> getCachedOnTheAirTVSeries();
  Future<void> cachePopularTVSeries(List<TVSeriesTable> tvSeries);
  Future<List<TVSeriesTable>> getCachedPopularTVSeries();
  Future<void> cacheTopRatedTVSeries(List<TVSeriesTable> tvSeries);
  Future<List<TVSeriesTable>> getCachedTopRatedTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTVWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertTVSeriesWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTVWatchlist(TVSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeTVSeriesWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result != null) {
      return TVSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTVSeries() async {
    final result = await databaseHelper.getWatchlistTVSeries();
    return result.map((data) => TVSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheOnTheAirTVSeries(List<TVSeriesTable> tvSeries) async {
    await databaseHelper.clearTVSeriesCache('on_the_air');
    await databaseHelper.insertTVSeriesCacheTransaction(tvSeries, 'on_the_air');
  }

  @override
  Future<void> cachePopularTVSeries(List<TVSeriesTable> tvSeries) async {
    await databaseHelper.clearTVSeriesCache('popular');
    await databaseHelper.insertTVSeriesCacheTransaction(tvSeries, 'popular');
  }

  @override
  Future<void> cacheTopRatedTVSeries(List<TVSeriesTable> tvSeries) async {
    await databaseHelper.clearTVSeriesCache('top_rated');
    await databaseHelper.insertTVSeriesCacheTransaction(tvSeries, 'top_rated');
  }

  @override
  Future<List<TVSeriesTable>> getCachedOnTheAirTVSeries() async {
    final result = await databaseHelper.getTVSeriesCache('on_the_air');
    if (result.isNotEmpty) {
      return result.map((data) => TVSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TVSeriesTable>> getCachedPopularTVSeries() async {
    final result = await databaseHelper.getTVSeriesCache('popular');
    if (result.isNotEmpty) {
      return result.map((data) => TVSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TVSeriesTable>> getCachedTopRatedTVSeries() async {
    final result = await databaseHelper.getTVSeriesCache('top_rated');
    if (result.isNotEmpty) {
      return result.map((data) => TVSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
