// Mocks generated by Mockito 5.1.0 from annotations
// in core/test/presentation/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:core/domain/entities/tv_series.dart' as _i10;
import 'package:core/domain/entities/tv_series_detail.dart' as _i7;
import 'package:core/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:core/domain/usecases/get_tv_series_recommendations.dart' as _i3;
import 'package:core/domain/usecases/get_watchlist_status_tv.dart' as _i4;
import 'package:core/domain/usecases/remove_watchlist_tv.dart' as _i6;
import 'package:core/domain/usecases/save_watchlist_tv.dart' as _i5;
import 'package:core/presentation/provider/tv_detail_notifier.dart' as _i8;
import 'package:core/utils/state_enum.dart' as _i9;
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

class _FakeGetTVDetail_0 extends _i1.Fake implements _i2.GetTVDetail {}

class _FakeGetTVSeriesRecommendations_1 extends _i1.Fake
    implements _i3.GetTVSeriesRecommendations {}

class _FakeGetWatchListStatusTV_2 extends _i1.Fake
    implements _i4.GetWatchListStatusTV {}

class _FakeSaveWatchlistTV_3 extends _i1.Fake implements _i5.SaveWatchlistTV {}

class _FakeRemoveWatchlistTV_4 extends _i1.Fake
    implements _i6.RemoveWatchlistTV {}

class _FakeTVSeriesDetail_5 extends _i1.Fake implements _i7.TVSeriesDetail {}

/// A class which mocks [TVDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVDetailNotifier extends _i1.Mock implements _i8.TVDetailNotifier {
  MockTVDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTVDetail get getTVDetail =>
      (super.noSuchMethod(Invocation.getter(#getTVDetail),
          returnValue: _FakeGetTVDetail_0()) as _i2.GetTVDetail);
  @override
  _i3.GetTVSeriesRecommendations get getTVRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getTVRecommendations),
              returnValue: _FakeGetTVSeriesRecommendations_1())
          as _i3.GetTVSeriesRecommendations);
  @override
  _i4.GetWatchListStatusTV get getWatchListStatus => (super.noSuchMethod(
      Invocation.getter(#getWatchListStatus),
      returnValue: _FakeGetWatchListStatusTV_2()) as _i4.GetWatchListStatusTV);
  @override
  _i5.SaveWatchlistTV get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlistTV_3()) as _i5.SaveWatchlistTV);
  @override
  _i6.RemoveWatchlistTV get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlistTV_4()) as _i6.RemoveWatchlistTV);
  @override
  _i7.TVSeriesDetail get tv => (super.noSuchMethod(Invocation.getter(#tv),
      returnValue: _FakeTVSeriesDetail_5()) as _i7.TVSeriesDetail);
  @override
  _i9.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#tvState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);
  @override
  List<_i10.TVSeries> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i10.TVSeries>[]) as List<_i10.TVSeries>);
  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTVDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTVDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TVSeriesDetail? tv) => (super.noSuchMethod(
      Invocation.method(#addWatchlist, [tv]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TVSeriesDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [tv]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatus, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
