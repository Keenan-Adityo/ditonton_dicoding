part of 'searchtv_bloc.dart';

@immutable
abstract class SearchTVState extends Equatable {
  const SearchTVState();
  
  @override
  List<Object> get props => [];
}

class SearchTVEmpty extends SearchTVState {}

class SearchTVLoading extends SearchTVState {}

class SearchTVError extends SearchTVState {
  final String message;

  const SearchTVError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTVHasData extends SearchTVState {
  final List<TVSeries> result;

  const SearchTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
