import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTV getTopRatedTV;

  TopRatedTvBloc(this.getTopRatedTV) : super(TopRatedTvEmpty()) {
    on<OnFetchTopRatedTV>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await getTopRatedTV.execute();

      result.fold((failure) {
        emit(TopRatedTvError(failure.message));
      }, (data) {
        emit(TopRatedTvHasData(data));
      });
    });
  }
}
