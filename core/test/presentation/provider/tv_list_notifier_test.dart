import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirTV, GetPopularTV, GetTopRatedTV])
void main() {
  late TVListNotifier provider;
  late MockGetOnAirTV mockGetOnAirTV;
  late MockGetPopularTV mockGetPopularTV;
  late MockGetTopRatedTV mockGetTopRatedTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTV = MockGetOnAirTV();
    mockGetPopularTV = MockGetPopularTV();
    mockGetTopRatedTV = MockGetTopRatedTV();
    provider = TVListNotifier(
      getOnAirTV: mockGetOnAirTV,
      getPopularTV: mockGetPopularTV,
      getTopRatedTV: mockGetTopRatedTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
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

  group('on the air tv', () {
    test('initialState should be Empty', () {
      expect(provider.onAirTVState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnAirTV();
      // assert
      verify(mockGetOnAirTV.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnAirTV();
      // assert
      expect(provider.onAirTVState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchOnAirTV();
      // assert
      expect(provider.onAirTVState, RequestState.Loaded);
      expect(provider.onAirTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTV();
      // assert
      expect(provider.onAirTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular TV', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Loaded);
      expect(provider.popularTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Loaded);
      expect(provider.topRatedTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}