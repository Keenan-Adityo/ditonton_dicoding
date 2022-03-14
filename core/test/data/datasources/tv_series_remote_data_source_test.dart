import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
    },
  );

  group(
    'get On Air TV Series',
    () {
      final tTVSeries = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/on_air_tv.json')))
          .tvSeriesList;
      test(
        'Should return list of TV Series model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient
                  .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
                  http.Response(readJson('dummy_data/on_air_tv.json'), 200));
          // act
          final result = await dataSource.getOnAirTV();
          // assert
          expect(result, equals(tTVSeries));
        },
      );
      test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient
                  .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getOnAirTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'get Popular TV Series',
    () {
      final tTVSeries = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/popular_tv.json')))
          .tvSeriesList;
      test(
        'Should return list of TV Series model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
                  http.Response(readJson('dummy_data/popular_tv.json'), 200));
          // act
          final result = await dataSource.getPopularTV();
          // assert
          expect(result, equals(tTVSeries));
        },
      );
      test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'get Top Rated TV Series',
    () {
      final tTVSeries = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/top_rated_tv.json')))
          .tvSeriesList;
      test(
        'Should return list of TV Series model when the response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async =>
                  http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
          // act
          final result = await dataSource.getTopRatedTV();
          // assert
          expect(result, equals(tTVSeries));
        },
      );
      test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedTV();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group('get tv series detail', () {
    final tId = 1;
    final tTVSeriesDetail = TVSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test('should return tv series detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTVSeriesDetail(tId);
      // assert
      expect(result, equals(tTVSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvSeriesList;
    final tId = 1;

    test('should return list of tv series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(result, equals(tTVSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_euphoria_tv.json')))
        .tvSeriesList;
    final tQuery = 'Euphoria';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_euphoria_tv.json'), 200));
      // act
      final result = await dataSource.searchTVSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}