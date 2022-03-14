import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/last_episode_to_air_model.dart';
import 'package:core/data/models/network_model.dart';
import 'package:core/data/models/production_country_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/spoken_language_model.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_table.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;

  setUp(
    () {
      mockLocalDataSource = MockTVSeriesLocalDataSource();
      mockRemoteDataSource = MockTVSeriesRemoteDataSource();
      repository = TVSeriesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
      );
    },
  );

  final tTVSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVSeriesModelList = <TVSeriesModel>[tTVSeriesModel];
  final tTVSeriesList = <TVSeries>[tTVSeries];

  group(
    'On The Air TV',
    () {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnAirTV())
            .thenAnswer((_) async => tTVSeriesModelList);
        // act
        final result = await repository.getOnAirTV();
        // assert
        verify(mockRemoteDataSource.getOnAirTV());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnAirTV()).thenThrow(ServerException());
        // act
        final result = await repository.getOnAirTV();
        // assert
        verify(mockRemoteDataSource.getOnAirTV());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnAirTV())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getOnAirTV();
        // assert
        verify(mockRemoteDataSource.getOnAirTV());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'Popular TV',
    () {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTV())
            .thenAnswer((_) async => tTVSeriesModelList);
        // act
        final result = await repository.getPopularTV();
        // assert
        verify(mockRemoteDataSource.getPopularTV());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
        // act
        final result = await repository.getPopularTV();
        // assert
        verify(mockRemoteDataSource.getPopularTV());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTV())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularTV();
        // assert
        verify(mockRemoteDataSource.getPopularTV());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'Top Rated TV',
    () {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTV())
            .thenAnswer((_) async => tTVSeriesModelList);
        // act
        final result = await repository.getTopRatedTV();
        // assert
        verify(mockRemoteDataSource.getTopRatedTV());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTV();
        // assert
        verify(mockRemoteDataSource.getTopRatedTV());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTV())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedTV();
        // assert
        verify(mockRemoteDataSource.getTopRatedTV());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'TV detail',
    () {
      final tId = 1;
      final tTVResponse = TVSeriesDetailResponse(
        adult: false,
        backdropPath: 'backdropPath',
        createdBy: ['createdBy'],
        episodeRunTime: [1, 2],
        firstAirDate: '2002-05-01',
        genres: [GenreModel(id: 1, name: 'Action')],
        homepage: 'homepage',
        id: 1,
        inProduction: false,
        languages: ['languages'],
        lastAirDate: 'lastAirDate',
        lastEpisodeToAir: LastEpisodeToAirModel(
          airDate: 'airDate',
          episodeNumber: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1.0,
          voteCount: 1,
        ),
        name: 'name',
        nextEpisodeToAir: 'nextEpisodeToAir',
        networks: [
          NetworkModel(
              name: 'name',
              id: 1,
              logoPath: 'logoPath',
              originCountry: 'originCountry'),
        ],
        numberOfEpisodes: 1,
        numberOfSeasons: 1,
        originCountry: ['originCountry'],
        originalLanguage: 'originalLanguage',
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: '/path.jpg',
        productionCompanies: ['productionCompanies'],
        productionCountries: [
          ProductionCountryModel(
            iso31661: 'iso31661',
            name: 'name',
          )
        ],
        seasons: [
          SeasonModel(
            airDate: '1',
            episodeCount: 1,
            id: 1,
            name: 'name',
            overview: 'overview',
            posterPath: '/path.jpg',
            seasonNumber: 1,
          )
        ],
        spokenLanguages: [
          SpokenLanguageModel(
            englishName: 'englishName',
            iso6391: 'iso6391',
            name: 'name',
          )
        ],
        status: 'status',
        tagline: 'tagline',
        type: 'type',
        voteAverage: 1,
        voteCount: 1,
      );

      test(
          'should return tv data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenAnswer((_) async => tTVResponse);
        // act
        final result = await repository.getTVSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));
        expect(result, equals(Right(testTVSeriesDetail)));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTVSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTVSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'TV Recommendations',
    () {
      final tTVSeriesList = <TVSeriesModel>[];
      final tId = 1;

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenAnswer((_) async => tTVSeriesList);
        // act
        final result = await repository.getTVSeriesRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVSeriesList);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTVSeriesRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTVSeriesRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'Search TV',
    () {
      final tQuery = 'euphoria';

      test('should return movie list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenAnswer((_) async => tTVSeriesModelList);
        // act
        final result = await repository.searchTVSeries(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTVSeriesList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenThrow(ServerException());
        // act
        final result = await repository.searchTVSeries(tQuery);
        // assert
        expect(result, Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchTVSeries(tQuery);
        // assert
        expect(result,
            Left(ConnectionFailure('Failed to connect to the network')));
      });
    },
  );

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTVWatchlist(TVSeriesTable.fromEntity(testTVSeriesDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTVWatchlist(TVSeriesTable.fromEntity(testTVSeriesDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTVWatchlist(TVSeriesTable.fromEntity(testTVSeriesDetail)))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTVWatchlist(TVSeriesTable.fromEntity(testTVSeriesDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TV Series', () {
    test('should return list of tv series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesTable]);
      // act
      final result = await repository.getWatchlistTVSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTVSeries]);
    });
  });
}
