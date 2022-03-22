import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late MockGetPopularTV mockGetPopularTV;
  late PopularTvBloc bloc;
  // late int eventCallCount;

  setUp(
    () {
      // eventCallCount = 0;
      mockGetPopularTV = MockGetPopularTV();
      bloc = PopularTvBloc(mockGetPopularTV);
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
      expect(bloc.state, PopularTvEmpty());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchPopularTV()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockGetPopularTV.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    return bloc;
  },
  act: (bloc) => bloc.add(OnFetchPopularTV()),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    PopularTvLoading(),
    const PopularTvError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockGetPopularTV.execute());
  },
);
}