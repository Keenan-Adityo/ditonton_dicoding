part of 'top_rated_tv_bloc.dart';

@immutable
abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvHasData extends TopRatedTvState {
  final List<TVSeries> result;

  const TopRatedTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object?> get props => [message];
}
