import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieListBloc(this.getNowPlayingMovies) : super(MovieListEmpty()) {
    on<OnFetchNowPlayingMovies>((event, emit) async {
      emit(MovieListLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });
  }
}
