import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class OnAirTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetOnAirTV getOnAirTV;

  OnAirTvListBloc(this.getOnAirTV) : super(TvListEmpty()) {
    on<OnFetchTVList>((event, emit) async {
      emit(TvListLoading());

      final result = await getOnAirTV.execute();

      result.fold((failure) {
        emit(TvListError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class PopularTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetPopularTV getPopularTV;

  PopularTvListBloc(this.getPopularTV) : super(TvListEmpty()) {
    on<OnFetchTVList>((event, emit) async {
      emit(TvListLoading());

      final result = await getPopularTV.execute();

      result.fold((failure) {
        emit(TvListError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}

class TopRatedTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTopRatedTV getTopRatedTV;

  TopRatedTvListBloc(this.getTopRatedTV) : super(TvListEmpty()) {
    on<OnFetchTVList>((event, emit) async {
      emit(TvListLoading());

      final result = await getTopRatedTV.execute();

      result.fold((failure) {
        emit(TvListError(failure.message));
      }, (data) {
        emit(TvListHasData(data));
      });
    });
  }
}
