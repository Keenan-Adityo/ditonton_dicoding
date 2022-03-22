import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getMovieDetail;
  final GetTVSeriesRecommendations getMovieRecommendations;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;
  late List<TVSeries> recommendation;
  late TVSeriesDetail movie;

  TvDetailBloc(
    this.saveWatchlist,
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.removeWatchlist,
  ) : super(TvDetailEmpty()) {
    on<OnFetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      detailResult.fold((failure) {
        emit(TvDetailError(failure.message));
      }, (detailData) {
        movie = detailData;
        emit(TvDetailRecommendationLoading());
        recommendationResult.fold((failure) {
          emit(TvDetailRecommendationError(failure.message));
        }, (recommendationData) {
          recommendation = recommendationData;
          emit(TvDetailRecommendationHasData(recommendationData));
        });

        emit(TvDetailHasData(
            detailData, _isAddedtoWatchlist, recommendation));
      });
    });

    on<OnAddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
        },
      );

      await loadWatchlistStatus(movie.id);
      emit(TvDetailHasData(movie, _isAddedtoWatchlist, recommendation));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          _watchlistMessage = failure.message;
        },
        (successMessage) async {
          _watchlistMessage = successMessage;
        },
      );

      await loadWatchlistStatus(movie.id);
      emit(TvDetailHasData(movie, _isAddedtoWatchlist, recommendation));
    });
  }

  
  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
  }
}
