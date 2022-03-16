
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetPopularTV getPopularTV;

  PopularTVNotifier(this.getPopularTV);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TVSeries> _tv = [];
  List<TVSeries> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTV() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}