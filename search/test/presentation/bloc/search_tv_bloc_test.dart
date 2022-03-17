import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv/searchtv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';


@GenerateMocks([SearchTV])
void main() {
  late SearchTVBloc searchBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchBloc = SearchTVBloc(mockSearchTV);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTVEmpty());
  });

  final tTVSeries = TVSeries(
  backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
  firstAirDate: '2019-06-16',
  genreIds: const [18],
  id: 85552,
  name: 'Euphoria',
  originalLanguage: 'en',
  originalName: 'Euphoria',
  overview:
      'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
  popularity: 4695.201,
  posterPath: '/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg',
  voteAverage: 8.4,
  voteCount: 7136,
);
  final tMovieList = <TVSeries>[tTVSeries];
  const tQuery = 'spiderman';

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedTV(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      SearchTVHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
  
  blocTest<SearchTVBloc, SearchTVState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockSearchTV.execute(tQuery))
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    return searchBloc;
  },
  act: (bloc) => bloc.add(const OnQueryChangedTV(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    SearchTVLoading(),
    const SearchTVError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockSearchTV.execute(tQuery));
  },
);
}