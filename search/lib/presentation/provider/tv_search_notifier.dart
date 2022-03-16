
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:search/domain/usecases/search_tv.dart';

class TVSearchNotifier extends ChangeNotifier {
  final SearchTV searchTV;

  TVSearchNotifier({required this.searchTV});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TVSeries> _searchResult = [];
  List<TVSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTV.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}