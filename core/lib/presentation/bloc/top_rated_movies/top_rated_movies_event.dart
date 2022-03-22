part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class OnFetchTopRatedMovies extends TopRatedMoviesEvent {}
