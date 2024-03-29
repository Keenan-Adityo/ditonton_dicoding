import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class NowPlayingMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieListBloc(this.getNowPlayingMovies) : super(MovieListEmpty()) {
    on<OnFetchMovieList>((event, emit) async {
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

class PopularMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieListBloc(this.getPopularMovies) : super(MovieListEmpty()) {
    on<OnFetchMovieList>((event, emit) async {
      emit(MovieListLoading());

      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });
  }
}

class TopRatedMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieListBloc(this.getTopRatedMovies) : super(MovieListEmpty()) {
    on<OnFetchMovieList>((event, emit) async {
      emit(MovieListLoading());

      final result = await getTopRatedMovies.execute();

      result.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });
  }
}