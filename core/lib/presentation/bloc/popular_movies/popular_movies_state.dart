part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;
 
  const PopularMoviesHasData(this.result);
 
  @override
  List<Object> get props => [result];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;
 
  const PopularMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}
