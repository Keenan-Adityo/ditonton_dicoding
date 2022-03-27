import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVSeriesRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  TvDetailBloc({
    required this.saveWatchlist,
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.removeWatchlist,}
  ) : super(TvDetailState.initial()) {
    on<OnFetchTvDetail>((event, emit) async {
      emit(state.copyWith(tvDetailState: RequestState.loading));

      final detailResult = await getTVDetail.execute(event.id);
      final recommendationResult =
          await getTVRecommendations.execute(event.id);

      detailResult.fold((failure) async {
        emit(state.copyWith(tvDetailState: RequestState.error));
      }, (detailData) async {
        emit(state.copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: detailData,
            message: '',
            tvRecommendationState: RequestState.loading));
        recommendationResult.fold((failure) {
          emit(state.copyWith(
            tvRecommendationState: RequestState.error,
            message: failure.message,
          ));
        }, (recommendationData) {
          emit(state.copyWith(
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: recommendationData,
            message: '',
          ));
        });
      });
    });

    on<OnAddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(event.tv.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tv);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(event.tv.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
