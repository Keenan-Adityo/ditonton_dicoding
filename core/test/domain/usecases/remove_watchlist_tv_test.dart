import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTV usecase;
  late MockTVSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTVSeriesRepository();
    usecase = RemoveWatchlistTV(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testTVSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}