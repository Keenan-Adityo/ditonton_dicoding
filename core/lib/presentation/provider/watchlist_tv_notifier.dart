import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTV = <TVSeries>[];
  List<TVSeries> get watchlistTV => _watchlistTV;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTV});

  final GetWatchlistTV getWatchlistTV;

  Future<void> fetchWatchlistTV() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTV = tvData;
        notifyListeners();
      },
    );
  }
}