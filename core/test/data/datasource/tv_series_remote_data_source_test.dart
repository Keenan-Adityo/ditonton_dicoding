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
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseURL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On Air TV', () {
    final tTVList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/on_air_tv.json')))
        .tvSeriesList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_air_tv.json'), 200));
      // act
      final result = await dataSource.getOnAirTV();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnAirTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tTVList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvSeriesList;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
      // act
      final result = await dataSource.getPopularTV();
      // assert
      expect(result, tTVList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tTVList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvSeriesList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedTV();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 1;
    final tTVDetail = TVSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTVSeriesDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTVList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_euphoria_tv.json')))
        .tvSeriesList;
    const tQuery = 'Euphoria';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$tQuery')))
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
              .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
