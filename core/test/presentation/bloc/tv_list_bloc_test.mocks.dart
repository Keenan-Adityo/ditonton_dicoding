// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/presentation/bloc/tv_list_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/domain/entities/tv_series.dart' as _i7;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:core/domain/usecases/get_on_air_tv.dart' as _i4;
import 'package:core/domain/usecases/get_popular_tv.dart' as _i8;
import 'package:core/domain/usecases/get_top_rated_tv.dart' as _i9;
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

/// A class which mocks [GetOnAirTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOnAirTV extends _i1.Mock implements _i4.GetOnAirTV {
  MockGetOnAirTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}

/// A class which mocks [GetPopularTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTV extends _i1.Mock implements _i8.GetPopularTV {
  MockGetPopularTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}

/// A class which mocks [GetTopRatedTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTV extends _i1.Mock implements _i9.GetTopRatedTV {
  MockGetTopRatedTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TVSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TVSeries>>>);
}
