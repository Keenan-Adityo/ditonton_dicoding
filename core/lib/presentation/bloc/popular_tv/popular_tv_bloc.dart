import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTV getPopularTV;

  PopularTvBloc(this.getPopularTV) : super(PopularTvEmpty()) {
    on<OnFetchPopularTV>((event, emit) async {
      emit(PopularTvLoading());
      final result = await getPopularTV.execute();

      result.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (data) {
          emit(PopularTvHasData(data));
        },
      );
    });
  }
}
