import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(
    () {
      mockTVSeriesRepository = MockTVSeriesRepository();
      usecase = GetTVDetail(mockTVSeriesRepository);
    },
  );

  final tID = 1;

  test(
    'Should return tv series detail from repository',
    () async {
      // arrange
      when(mockTVSeriesRepository.getTVSeriesDetail(tID))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      // act
      final result = await usecase.execute(tID);
      // assert
      expect(result, Right(testTVSeriesDetail));
    },
  );
}
