import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/presentation/provider/watchlist_tv_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTV])
void main() {
  late WatchlistTVNotifier provider;
  late MockGetWatchlistTV mockGetWatchlistTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTV = MockGetWatchlistTV();
    provider = WatchlistTVNotifier(
      getWatchlistTV: mockGetWatchlistTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTV.execute())
        .thenAnswer((_) async => Right([testWatchlistTVSeries]));
    // act
    await provider.fetchWatchlistTV();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistTV, [testWatchlistTVSeries]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTV.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTV();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}