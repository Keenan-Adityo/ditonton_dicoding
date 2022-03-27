import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVSeriesRecommendations,
  GetWatchListStatusTV,
  SaveWatchlistTV,
  RemoveWatchlistTV,
])
void main() {
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVSeriesRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatusTV mockGetWatchListStatusTV;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlistTV mockRemoveWatchlistTV;
  late TvDetailBloc bloc;

  setUp(
    () {
      mockGetTVDetail = MockGetTVDetail();
      mockGetTVRecommendations = MockGetTVSeriesRecommendations();
      mockGetWatchListStatusTV = MockGetWatchListStatusTV();
      mockSaveWatchlistTV = MockSaveWatchlistTV();
      mockRemoveWatchlistTV = MockRemoveWatchlistTV();
      bloc = TvDetailBloc(
        saveWatchlist: mockSaveWatchlistTV,
        getTVDetail: mockGetTVDetail,
        getTVRecommendations: mockGetTVRecommendations,
        getWatchListStatus: mockGetWatchListStatusTV,
        removeWatchlist: mockRemoveWatchlistTV,
      );
    },
  );

  const tId = 1;
  final tvDetailStateInit = TvDetailState.initial();
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

  final tTVSeriesDetail = TVSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: const [1, 2],
    firstAirDate: '2002-05-01',
    genres: const [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    languages: const ['languages'],
    name: 'name',
    nextEpisodeToAir: 'nextEpisodeToAir',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: '/path.jpg',
    seasons: [
      Season(
        airDate: '1',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: '/path.jpg',
        seasonNumber: 1,
      )
    ],
    status: 'status',
    voteAverage: 1,
    voteCount: 1,
  );

  group(
    'Get TV Detail',
    () {
      blocTest<TvDetailBloc, TvDetailState>(
        'Should change tv when data is gotten succesfully',
        build: () {
          when(mockGetTVDetail.execute(tId))
              .thenAnswer((_) async => Right(tTVSeriesDetail));
          when(mockGetTVRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tTVList));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(tvDetailState: RequestState.loading),
          tvDetailStateInit.copyWith(
            tvRecommendationState: RequestState.loading,
            tvDetail: tTVSeriesDetail,
            tvDetailState: RequestState.loaded,
            message: '',
          ),
          tvDetailStateInit.copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: tTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: tTVList,
            message: '',
          ),
        ],
        verify: (bloc) {
          mockGetTVDetail.execute(tId);
          mockGetTVRecommendations.execute(tId);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should return error when data is failed',
        build: () {
          when(mockGetTVDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetTVRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(tvDetailState: RequestState.loading),
          tvDetailStateInit.copyWith(
            tvRecommendationState: RequestState.empty,
            tvDetailState: RequestState.error,
          ),
        ],
        verify: (bloc) {
          mockGetTVDetail.execute(tId);
        },
      );
    },
  );

  group(
    'Watchlist',
    () {
      blocTest<TvDetailBloc, TvDetailState>(
        'Should get the watchlist status',
        build: () {
          when(mockGetWatchListStatusTV.execute(1))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(const OnLoadWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          mockGetWatchListStatusTV.execute(1);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit watchlistmessage and add the watchlist when added to watchlist',
        build: () {
          when(mockSaveWatchlistTV.execute(tTVSeriesDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatusTV.execute(tTVSeriesDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) {
          bloc.add( OnAddWatchlist(tTVSeriesDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(watchlistMessage: 'Success'),
          tvDetailStateInit.copyWith(
              isAddedToWatchlist: true, watchlistMessage: 'Success'),
        ],
        verify: (bloc) {
          mockSaveWatchlistTV.execute(tTVSeriesDetail);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit failed to add into watchlist when failed',
        build: () {
          when(mockSaveWatchlistTV.execute(tTVSeriesDetail))
              .thenAnswer((_) async => const Left(CommonFailure('')));
          when(mockGetWatchListStatusTV.execute(tTVSeriesDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) {
          bloc.add(OnAddWatchlist(tTVSeriesDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: ''),
        ],
        verify: (bloc) {
          mockSaveWatchlistTV.execute(tTVSeriesDetail);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit watchlistmessage and remove the watchlist when removed from watchlist',
        build: () {
          when(mockRemoveWatchlistTV.execute(tTVSeriesDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatusTV.execute(tTVSeriesDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) {
          bloc.add( OnRemoveWatchlist(tTVSeriesDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: 'Success'),
        ],
        verify: (bloc) {
          mockRemoveWatchlistTV.execute(tTVSeriesDetail);
          mockGetWatchListStatusTV.execute(tTVSeriesDetail.id);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit failed when fail to remove watchlist',
        build: () {
          when(mockRemoveWatchlistTV.execute(tTVSeriesDetail))
              .thenAnswer((_) async => const Left(CommonFailure('')));
          when(mockGetWatchListStatusTV.execute(tTVSeriesDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) {
          bloc.add( OnRemoveWatchlist(tTVSeriesDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: ''),
          tvDetailStateInit.copyWith(
              isAddedToWatchlist: true, watchlistMessage: ''),
        ],
        verify: (bloc) {
          mockRemoveWatchlistTV.execute(tTVSeriesDetail);
          mockGetWatchListStatusTV.execute(tTVSeriesDetail.id);
        },
      );
    },
  );
}
