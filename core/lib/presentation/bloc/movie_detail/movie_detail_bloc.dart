import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.loading));

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      detailResult.fold((failure) {
        emit(state.copyWith(movieDetailState: RequestState.error));
      }, (detailData) {
        emit(state.copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: detailData,
          movieRecommendationState: RequestState.loading,
          message: '',
        ));
        recommendationResult.fold((failure) {
          emit(state.copyWith(movieRecommendationState: RequestState.error));
        }, (recommendationData) {
          emit(state.copyWith(
            movieRecommendationState: RequestState.loaded,
            movieRecommendations: recommendationData,
            message: '',
          ));
        });
      });
    });

    on<OnAddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(event.movie.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(event.movie.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
