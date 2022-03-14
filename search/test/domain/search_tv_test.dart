import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';

import '../helpers/test_helper.mocks.dart';


void main() {
  late SearchTV usecase;
  late MockTVSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTVSeriesRepository();
    usecase = SearchTV(mockMovieRepository);
  });

  final tTVSeries = <TVSeries>[];
  final tQuery = 'Euphoria';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVSeries));
  });
}
