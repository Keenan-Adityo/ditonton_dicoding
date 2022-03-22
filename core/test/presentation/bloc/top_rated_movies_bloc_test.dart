import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc bloc;
  // late int eventCallCount;

  setUp(
    () {
      // eventCallCount = 0;
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      bloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    },
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test(
    'Should return empty state when first initialized',
    () {
      expect(bloc.state, TopRatedMoviesEmpty());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockGetTopRatedMovies.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    return bloc;
  },
  act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    TopRatedMoviesLoading(),
    const TopRatedMoviesError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockGetTopRatedMovies.execute());
  },
);
}
