import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetOnAirTV getOnAirTV;

  TvListBloc(this.getOnAirTV) : super(TvListEmpty()) {
    on<OnFetchOnAirTv>((event, emit) async {
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
