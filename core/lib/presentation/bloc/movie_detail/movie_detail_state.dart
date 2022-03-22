part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;
  final bool isAddedToWatchlist;
  final List<Movie> recommendationResult;

  const MovieDetailHasData(this.result, this.isAddedToWatchlist, this.recommendationResult);
  @override
  List<Object?> get props => [result, isAddedToWatchlist, recommendationResult];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailRecommendationLoading extends MovieDetailState {}

class MovieDetailRecommendationHasData extends MovieDetailState {
  final List<Movie> result;

  const MovieDetailRecommendationHasData(this.result);
  @override
  List<Object?> get props => [result];
}

class MovieDetailRecommendationError extends MovieDetailState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
