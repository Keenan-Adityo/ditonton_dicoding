part of 'tv_list_bloc.dart';

@immutable
abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object?> get props => [];
}

class TvListEmpty extends TvListState {}

class TvListLoading extends TvListState {}

class TvListHasData extends TvListState {
  final List<TVSeries> result;

  const TvListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvListError extends TvListState {
  final String message;

  const TvListError(this.message);

  @override
  List<Object> get props => [message];
}
