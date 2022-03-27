import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieDetailBloc bloc;

  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      mockGetWatchListStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      bloc = MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations,
        getWatchListStatus: mockGetWatchListStatus,
        removeWatchlist: mockRemoveWatchlist,
        saveWatchlist: mockSaveWatchlist,
      );
    },
  );

  final tId = 1;
  final movieDetailStateInit = MovieDetailState.initial();
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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
  final tMovies = <Movie>[tMovie];

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group(
    'Get Movie Detail',
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should change movie when data is gotten succesfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(movieDetailState: RequestState.loading),
          movieDetailStateInit.copyWith(
            movieRecommendationState: RequestState.loading,
            movieDetail: tMovieDetail,
            movieDetailState: RequestState.loaded,
            message: '',
          ),
          movieDetailStateInit.copyWith(
            movieDetailState: RequestState.loaded,
            movieDetail: tMovieDetail,
            movieRecommendationState: RequestState.loaded,
            movieRecommendations: tMovies,
            message: '',
          ),
        ],
        verify: (bloc) {
          mockGetMovieDetail.execute(tId);
          mockGetMovieRecommendations.execute(tId);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should return error when data is failed',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(movieDetailState: RequestState.loading),
          movieDetailStateInit.copyWith(
            movieRecommendationState: RequestState.empty,
            movieDetailState: RequestState.error,
          ),
        ],
        verify: (bloc) {
          mockGetMovieDetail.execute(tId);
        },
      );
    },
  );

  group(
    'Watchlist',
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should get the watchlist status',
        build: () {
          when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistStatus(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(isAddedToWatchlist: true),
        ],
        verify: (bloc) {
          mockGetWatchListStatus.execute(1);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit watchlistmessage and add the watchlist when added to watchlist',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) {
          bloc.add(const OnAddWatchlist(testMovieDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(watchlistMessage: 'Success'),
          movieDetailStateInit.copyWith(
              isAddedToWatchlist: true, watchlistMessage: 'Success'),
        ],
        verify: (bloc) {
          mockSaveWatchlist.execute(testMovieDetail);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit failed to add into watchlist when failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(CommonFailure('')));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) {
          bloc.add(const OnAddWatchlist(testMovieDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: ''),
        ],
        verify: (bloc) {
          mockSaveWatchlist.execute(testMovieDetail);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit watchlistmessage and remove the watchlist when removed from watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => const Right('Success'));
          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) {
          bloc.add(const OnRemoveWatchlist(tMovieDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: 'Success'),
        ],
        verify: (bloc) {
          mockRemoveWatchlist.execute(tMovieDetail);
          mockGetWatchListStatus.execute(tMovieDetail.id);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit failed when fail to remove watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => const Left(CommonFailure('')));
          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) {
          bloc.add(const OnRemoveWatchlist(tMovieDetail));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(
              isAddedToWatchlist: false, watchlistMessage: ''),
              movieDetailStateInit.copyWith(
              isAddedToWatchlist: true, watchlistMessage: ''),
        ],
        verify: (bloc) {
          mockRemoveWatchlist.execute(tMovieDetail);
          mockGetWatchListStatus.execute(tMovieDetail.id);
        },
      );
    },
  );
}
