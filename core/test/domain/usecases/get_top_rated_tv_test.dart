import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetTopRatedTV usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(
    () {
      mockTVSeriesRepository = MockTVSeriesRepository();
      usecase = GetTopRatedTV(mockTVSeriesRepository);
    },
  );

  final tTVSeries = <TVSeries>[];

  test(
    'Should return list of tv series from repository',
    () async {
      // arrange
      when(mockTVSeriesRepository.getTopRatedTV())
          .thenAnswer((_) async => Right(tTVSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tTVSeries));
    },
  );
}
