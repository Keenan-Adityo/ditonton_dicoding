import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _onAirTV = <TVSeries>[];
  List<TVSeries> get onAirTV => _onAirTV;

  RequestState _onAirTVState = RequestState.Empty;
  RequestState get onAirTVState => _onAirTVState;

  var _popularTV = <TVSeries>[];
  List<TVSeries> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.Empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TVSeries>[];
  List<TVSeries> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.Empty;
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
    _onAirTVState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTV.execute();
    result.fold(
      (failure) {
        _onAirTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onAirTVState = RequestState.Loaded;
        _onAirTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.Loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.Loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
