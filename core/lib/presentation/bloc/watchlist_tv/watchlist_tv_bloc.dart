import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTV getWatchlistTV;

  WatchlistTvBloc(this.getWatchlistTV) : super(WatchlistTvEmpty()) {
    on<OnFetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await getWatchlistTV.execute();

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (data) {
        emit(WatchlistTvHasData(data));
      });
    });
  }
}
