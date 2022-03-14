import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

class TopRatedTVNotifier extends ChangeNotifier {
  final GetTopRatedTV getTopRatedTV;

  TopRatedTVNotifier({required this.getTopRatedTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeries> _tv = [];
  List<TVSeries> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTV() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
