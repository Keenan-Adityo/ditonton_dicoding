part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int id;

  const OnFetchTvDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class OnAddWatchlist extends TvDetailEvent {
  final TVSeriesDetail movie;

  const OnAddWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}

class OnRemoveWatchlist extends TvDetailEvent {
  final TVSeriesDetail movie;

  const OnRemoveWatchlist(this.movie);

  @override
  List<Object?> get props => [movie];
}
