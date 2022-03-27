import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTV, GetPopularTV, GetTopRatedTV])
void main() {
  late OnAirTvListBloc onAirTvListBloc;
  late MockGetOnAirTV mockGetOnAirTv;
  late PopularTvListBloc popularTvListBloc;
  late MockGetPopularTV mockGetPopularTV;
  late TopRatedTvListBloc topRatedTvListBloc;
  late MockGetTopRatedTV mockGetTopRatedTV;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTV();
    onAirTvListBloc = OnAirTvListBloc(mockGetOnAirTv);
    mockGetPopularTV = MockGetPopularTV();
    popularTvListBloc = PopularTvListBloc(mockGetPopularTV);
    mockGetTopRatedTV = MockGetTopRatedTV();
    topRatedTvListBloc = TopRatedTvListBloc(mockGetTopRatedTV);
  });

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

  group('On Air Tv list', () {
    test('Should return empty when initialize', () {
      expect(onAirTvListBloc.state, TvListEmpty());
    });

    blocTest<OnAirTvListBloc, TvListState> (
      'Should emit [TvListLoading, TvListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Right(tTVList));
        return onAirTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListHasData(tTVList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTv.execute());
      },
    );

    blocTest<OnAirTvListBloc, TvListState> (
      'Should emit [tvListLoading, tvListError] when get Failure',
      build: () {
        when(mockGetOnAirTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return onAirTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetOnAirTv.execute());
      },
    );
  });

  group('popular tv list', () {
    test('Shuld return empty state when initialize', () {
      expect(popularTvListBloc.state, TvListEmpty());
    });

    blocTest<PopularTvListBloc, TvListState> (
      'Should emit [TvListLoading, TvListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVList));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListHasData(tTVList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTV.execute());
      },
    );

    blocTest<PopularTvListBloc, TvListState> (
      'Should emit [TvListLoading, TvListError] when get Failure',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTV.execute());
      },
    );
  });

  group('top rated Tv list', () {
    test('Should return empty state when intialize', () {
      expect(topRatedTvListBloc.state, TvListEmpty());
    });

    blocTest<TopRatedTvListBloc, TvListState> (
      'Should emit [TvListLoading, TvListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVList));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListHasData(tTVList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTV.execute());
      },
    );

    blocTest<TopRatedTvListBloc, TvListState> (
      'Should emit [TvListLoading, TvListError] when get Failure',
      build: () {
        when(mockGetTopRatedTV.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVList()),
      expect: () => [
        TvListLoading(),
        TvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTV.execute());
      },
    );
  });
}