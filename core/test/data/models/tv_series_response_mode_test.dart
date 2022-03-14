import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: null,
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

  final tTVSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTVSeriesModel]);

  group(
    'fromJson',
    () {
      test('Should return a valid model from json', () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(readJson('dummy_data/on_air_tv.json'));
        // act
        final result = TVSeriesResponse.fromJson(jsonMap);
        // assert
        expect(result, tTVSeriesResponseModel);
      });
    },
  );

  group(
    'toJson',
    () {
      test(
        'Should return a json map containing proper data',
        () async {
          // arrange

          // act
          final result = tTVSeriesResponseModel.toJson();
          // assert
          final expectedJsonMap = {
            "results": [
              {
                "backdrop_path": "backdropPath",
                "first_air_date": null,
                "genre_ids": [1, 2, 3],
                "id": 1,
                "name": "name",
                "origin_country": ["originCountry"],
                "original_language": "originalLanguage",
                "original_name": "originalName",
                "overview": "overview",
                "popularity": 1.0,
                "poster_path": "posterPath",
                "vote_average": 1.0,
                "vote_count": 1,
              }
            ],
          };

          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
