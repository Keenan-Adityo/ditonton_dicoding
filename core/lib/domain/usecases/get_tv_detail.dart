import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class GetTVDetail {
  final TVSeriesRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
