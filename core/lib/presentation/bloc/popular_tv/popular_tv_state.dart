part of 'popular_tv_bloc.dart';

@immutable
abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object?> get props => [];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvHasData extends PopularTvState {
  final List<TVSeries> result;

  const PopularTvHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularTvError extends PopularTvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object?> get props => [message];
}
