part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object?> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailHasData extends TvDetailState {
  final TVSeriesDetail result;
  final bool isAddedToWatchlist;
  final List<TVSeries> recommendationResult;

  const TvDetailHasData(
      this.result, this.isAddedToWatchlist, this.recommendationResult);
  @override
  List<Object?> get props => [result, isAddedToWatchlist, recommendationResult];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvDetailRecommendationLoading extends TvDetailState {}

class TvDetailRecommendationHasData extends TvDetailState {
  final List<TVSeries> result;

  const TvDetailRecommendationHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class TvDetailRecommendationError extends TvDetailState {
  final String message;

  const TvDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
