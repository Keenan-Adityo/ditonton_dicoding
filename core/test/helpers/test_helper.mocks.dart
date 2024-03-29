// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i26;

import 'package:core/common/network_info.dart' as _i24;
import 'package:core/data/datasources/db/database_helper.dart' as _i15;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i13;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i11;
import 'package:core/data/datasources/tv_series_local_data_source.dart' as _i23;
import 'package:core/data/datasources/tv_series_remote_data_source.dart'
    as _i21;
import 'package:core/data/models/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie_model.dart' as _i12;
import 'package:core/data/models/movie_table.dart' as _i14;
import 'package:core/data/models/tv_series_detail_model.dart' as _i4;
import 'package:core/data/models/tv_series_model.dart' as _i22;
import 'package:core/data/models/tv_series_table.dart' as _i17;
import 'package:core/domain/entities/movie.dart' as _i9;
import 'package:core/domain/entities/movie_detail.dart' as _i10;
import 'package:core/domain/entities/tv_series.dart' as _i19;
import 'package:core/domain/entities/tv_series_detail.dart' as _i20;
import 'package:core/domain/repositories/movie_repository.dart' as _i6;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i18;
import 'package:core/utils/failure.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i16;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTVSeriesDetailResponse_2 extends _i1.Fake
    implements _i4.TVSeriesDetailResponse {}

class _FakeResponse_3 extends _i1.Fake implements _i5.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i5.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
              _FakeEither_0<_i8.Failure, _i10.MovieDetail>())) as _i7
          .Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
              _FakeEither_0<_i8.Failure, List<_i9.Movie>>())) as _i7
          .Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
      as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]))
          as _i7.Future<List<_i12.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i13.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i14.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i14.MovieTable?>.value())
          as _i7.Future<_i14.MovieTable?>);
  @override
  _i7.Future<List<_i14.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
      as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cachePopularMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cachePopularMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedPopularMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
  @override
  _i7.Future<void> cacheTopRatedMovies(List<_i14.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheTopRatedMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i14.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedTopRatedMovies, []),
              returnValue:
                  Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]))
          as _i7.Future<List<_i14.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i15.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i16.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i16.Database?>.value())
          as _i7.Future<_i16.Database?>);
  @override
  _i7.Future<int> insertMovieWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> insertTVSeriesWatchlist(_i17.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
          Invocation.method(#insertTVSeriesWatchlist, [tvSeries]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeMovieWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeTVSeriesWatchlist(_i17.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(
          Invocation.method(#removeTVSeriesWatchlist, [tvSeries]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<Map<String, dynamic>?> getTVSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVSeries, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<void> insertMovieCacheTransaction(
          List<_i14.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertMovieCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> insertTVSeriesCacheTransaction(
          List<_i17.TVSeriesTable>? tvs, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertTVSeriesCacheTransaction, [tvs, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getMovieCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#getMovieCache, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getTVSeriesCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesCache, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> clearMovieCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearMovieCache, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> clearTVSeriesCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearTVSeriesCache, [category]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
}

/// A class which mocks [TVSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRepository extends _i1.Mock
    implements _i18.TVSeriesRepository {
  MockTVSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>> getOnAirTV() =>
      (super.noSuchMethod(Invocation.method(#getOnAirTV, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i20.TVSeriesDetail>> getTVSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, _i20.TVSeriesDetail>>.value(
                      _FakeEither_0<_i8.Failure, _i20.TVSeriesDetail>()))
          as _i7.Future<_i2.Either<_i8.Failure, _i20.TVSeriesDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>
      getTVSeriesRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTVSeriesRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>> searchTVSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i20.TVSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i20.TVSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither_0<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>
      getWatchlistTVSeries() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTVSeries, []),
              returnValue:
                  Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>.value(
                      _FakeEither_0<_i8.Failure, List<_i19.TVSeries>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i19.TVSeries>>>);
}

/// A class which mocks [TVSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesRemoteDataSource extends _i1.Mock
    implements _i21.TVSeriesRemoteDataSource {
  MockTVSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i22.TVSeriesModel>> getOnAirTV() => (super.noSuchMethod(
          Invocation.method(#getOnAirTV, []),
          returnValue:
              Future<List<_i22.TVSeriesModel>>.value(<_i22.TVSeriesModel>[]))
      as _i7.Future<List<_i22.TVSeriesModel>>);
  @override
  _i7.Future<List<_i22.TVSeriesModel>> getPopularTV() => (super.noSuchMethod(
          Invocation.method(#getPopularTV, []),
          returnValue:
              Future<List<_i22.TVSeriesModel>>.value(<_i22.TVSeriesModel>[]))
      as _i7.Future<List<_i22.TVSeriesModel>>);
  @override
  _i7.Future<List<_i22.TVSeriesModel>> getTopRatedTV() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTV, []),
          returnValue:
              Future<List<_i22.TVSeriesModel>>.value(<_i22.TVSeriesModel>[]))
      as _i7.Future<List<_i22.TVSeriesModel>>);
  @override
  _i7.Future<_i4.TVSeriesDetailResponse> getTVSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesDetail, [id]),
              returnValue: Future<_i4.TVSeriesDetailResponse>.value(
                  _FakeTVSeriesDetailResponse_2()))
          as _i7.Future<_i4.TVSeriesDetailResponse>);
  @override
  _i7.Future<List<_i22.TVSeriesModel>> getTVSeriesRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesRecommendations, [id]),
          returnValue: Future<List<_i22.TVSeriesModel>>.value(
              <_i22.TVSeriesModel>[])) as _i7.Future<List<_i22.TVSeriesModel>>);
  @override
  _i7.Future<List<_i22.TVSeriesModel>> searchTVSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVSeries, [query]),
          returnValue: Future<List<_i22.TVSeriesModel>>.value(
              <_i22.TVSeriesModel>[])) as _i7.Future<List<_i22.TVSeriesModel>>);
}

/// A class which mocks [TVSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVSeriesLocalDataSource extends _i1.Mock
    implements _i23.TVSeriesLocalDataSource {
  MockTVSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertTVWatchlist(_i17.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#insertTVWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeTVWatchlist(_i17.TVSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeTVWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i17.TVSeriesTable?> getTVSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVSeriesById, [id]),
              returnValue: Future<_i17.TVSeriesTable?>.value())
          as _i7.Future<_i17.TVSeriesTable?>);
  @override
  _i7.Future<List<_i17.TVSeriesTable>> getWatchlistTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVSeries, []),
          returnValue: Future<List<_i17.TVSeriesTable>>.value(
              <_i17.TVSeriesTable>[])) as _i7.Future<List<_i17.TVSeriesTable>>);
  @override
  _i7.Future<void> cacheOnTheAirTVSeries(List<_i17.TVSeriesTable>? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#cacheOnTheAirTVSeries, [tvSeries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i17.TVSeriesTable>> getCachedOnTheAirTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getCachedOnTheAirTVSeries, []),
          returnValue: Future<List<_i17.TVSeriesTable>>.value(
              <_i17.TVSeriesTable>[])) as _i7.Future<List<_i17.TVSeriesTable>>);
  @override
  _i7.Future<void> cachePopularTVSeries(List<_i17.TVSeriesTable>? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#cachePopularTVSeries, [tvSeries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i17.TVSeriesTable>> getCachedPopularTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getCachedPopularTVSeries, []),
          returnValue: Future<List<_i17.TVSeriesTable>>.value(
              <_i17.TVSeriesTable>[])) as _i7.Future<List<_i17.TVSeriesTable>>);
  @override
  _i7.Future<void> cacheTopRatedTVSeries(List<_i17.TVSeriesTable>? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#cacheTopRatedTVSeries, [tvSeries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<List<_i17.TVSeriesTable>> getCachedTopRatedTVSeries() =>
      (super.noSuchMethod(Invocation.method(#getCachedTopRatedTVSeries, []),
          returnValue: Future<List<_i17.TVSeriesTable>>.value(
              <_i17.TVSeriesTable>[])) as _i7.Future<List<_i17.TVSeriesTable>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i24.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i5.Response>.value(_FakeResponse_3()))
          as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i7.Future<_i26.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
