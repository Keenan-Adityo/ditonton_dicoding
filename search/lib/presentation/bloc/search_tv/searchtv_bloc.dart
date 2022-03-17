import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/transformers.dart';
import 'package:search/domain/usecases/search_tv.dart';

part 'searchtv_event.dart';
part 'searchtv_state.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTV _searchTV;

  SearchTVBloc(this._searchTV) : super(SearchTVEmpty()) {
    on<OnQueryChangedTV>((event, emit) async {
      final query = event.query;

      emit(SearchTVLoading());
      final result = await _searchTV.execute(query);

      result.fold(
        (failure) {
          emit(SearchTVError(failure.message));
        },
        (data) {
          emit(SearchTVHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
