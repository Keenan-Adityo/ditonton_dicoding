part of 'watchlist_tv_bloc.dart';

@immutable
abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvHasData extends WatchlistTvState {
  final List<TVSeries> result;

  const WatchlistTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object?> get props => [message];
}
