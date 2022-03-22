
import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedTvBloc bloc;
  // late int eventCallCount;

  setUp(
    () {
      // eventCallCount = 0;
      mockGetTopRatedTV = MockGetTopRatedTV();
      bloc = TopRatedTvBloc(mockGetTopRatedTV);
    },
  );

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVList = <TVSeries>[tTVSeries];

  test(
    'Should return empty state when first initialized',
    () {
      expect(bloc.state, TopRatedTvEmpty());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTopRatedTV()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockGetTopRatedTV.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    return bloc;
  },
  act: (bloc) => bloc.add(OnFetchTopRatedTV()),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    TopRatedTvLoading(),
    const TopRatedTvError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockGetTopRatedTV.execute());
  },
);
}
