import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _onAirTV = <TVSeries>[];
  List<TVSeries> get onAirTV => _onAirTV;

  RequestState _onAirTVState = RequestState.empty;
  RequestState get onAirTVState => _onAirTVState;

  var _popularTV = <TVSeries>[];
  List<TVSeries> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TVSeries>[];
  List<TVSeries> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.empty;
  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getOnAirTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  final GetOnAirTV getOnAirTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  Future<void> fetchOnAirTV() async {
    _onAirTVState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTV.execute();
    result.fold(
      (failure) {
        _onAirTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onAirTVState = RequestState.loaded;
        _onAirTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
