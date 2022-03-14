import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class GetPopularTV {
  final TVSeriesRepository repository;

  GetPopularTV(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getPopularTV();
  }
}
