import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Detail TV Page should display loading circle when loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvDetailState.initial()
        .copyWith(tvDetailState: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'should display loading in the recommendation list when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      tvDetailState: RequestState.loaded,
      tvDetail: testTVSeriesDetail,
      tvRecommendationState: RequestState.loading,
      tvRecommendations: <TVSeries>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      tvDetailState: RequestState.loaded,
      tvDetail: testTVSeriesDetail,
      tvRecommendationState: RequestState.loaded,
      tvRecommendations: [testTVSeries],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      tvDetailState: RequestState.loaded,
      tvDetail: testTVSeriesDetail,
      tvRecommendationState: RequestState.loaded,
      tvRecommendations: [testTVSeries],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          TvDetailState.initial().copyWith(
            tvDetailState: RequestState.loaded,
            tvDetail: testTVSeriesDetail,
            tvRecommendationState: RequestState.loaded,
            tvRecommendations: [testTVSeries],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Detail Movie Page should display Error Text when No Internet Network (Error)',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvDetailState.initial()
        .copyWith(
            tvDetailState: RequestState.error,
            message: 'Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}