import 'dart:convert';

import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getOnAirTV();
  Future<List<TVSeriesModel>> getPopularTV();
  Future<List<TVSeriesModel>> getTopRatedTV();
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id);
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseURL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getOnAirTV() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTV() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTV() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseURL/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return TVSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseURL/tv/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final response = await client
        .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
