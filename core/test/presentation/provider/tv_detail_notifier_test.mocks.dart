// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/presentation/provider/tv_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/domain/entities/tv_series.dart' as _i9;
import 'package:core/domain/entities/tv_series_detail.dart' as _i7;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:core/domain/usecases/get_tv_detail.dart' as _i4;
import 'package:core/domain/usecases/get_tv_series_recommendations.dart' as _i8;
import 'package:core/domain/usecases/get_watchlist_status_tv.dart' as _i10;
import 'package:core/domain/usecases/remove_watchlist_tv.dart' as _i12;
import 'package:core/domain/usecases/save_watchlist_tv.dart' as _i11;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTVSeriesRepository_0 extends _i1.Fake
    implements _i2.TVSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTVDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVDetail extends _i1.Mock implements _i4.GetTVDetail {
  MockGetTVDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>.value(
                      _FakeEither_1<_i6.Failure, _i7.TVSeriesDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>);
}

/// A class which mocks [GetTVSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVSeriesRecommendations extends _i1.Mock
    implements _i8.GetTVSeriesRecommendations {
  MockGetTVSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i9.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TVSeries>>>);
}

/// A class which mocks [GetWatchListStatusTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTV extends _i1.Mock
    implements _i10.GetWatchListStatusTV {
  MockGetWatchListStatusTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTV extends _i1.Mock implements _i11.SaveWatchlistTV {
  MockSaveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeriesDetail) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeriesDetail]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTV extends _i1.Mock implements _i12.RemoveWatchlistTV {
  MockRemoveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TVSeriesDetail? tvSeriesDetail) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeriesDetail]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}