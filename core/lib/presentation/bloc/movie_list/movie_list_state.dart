part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListHasData extends MovieListState {
  final List<Movie> result;

  const MovieListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError(this.message);

  @override
  List<Object> get props => [message];
}
