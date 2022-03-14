import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTV usecase;
  late MockTVSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTVSeriesRepository();
    usecase = SaveWatchlistTV(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testTVSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
