import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class GetTVSeriesRecommendations {
  final TVSeriesRepository repository;

  GetTVSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(id) {
    return repository.getTVSeriesRecommendations(id);
  }
}