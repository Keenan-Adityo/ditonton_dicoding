import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTVWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTVWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTVWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVSeriesWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTVWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(tId))
          .thenAnswer((_) async => testTVSeriesMap);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, testTVSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TVSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTVSeries();
      // assert
      expect(result, [testTVSeriesTable]);
    });
  });
  group('cache tv', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearTVSeriesCache('on_the_air'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheOnTheAirTVSeries([testTVSeriesCache]);
      // assert
      verify(mockDatabaseHelper.clearTVSeriesCache('on_the_air'));
      verify(mockDatabaseHelper
          .insertTVSeriesCacheTransaction([testTVSeriesCache], 'on_the_air'));
    });

    test('should return list of tv from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesCache('on_the_air'))
          .thenAnswer((_) async => [testTVSeriesCacheMap]);
      // act
      final result = await dataSource.getCachedOnTheAirTVSeries();
      // assert
      expect(result, [testTVSeriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getTVSeriesCache('on_the_air'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedOnTheAirTVSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}