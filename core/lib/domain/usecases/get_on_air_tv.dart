import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class GetOnAirTV {
  final TVSeriesRepository repository;

  GetOnAirTV(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnAirTV();
  }
}
