import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class RemoveWatchlistTV {
  final TVSeriesRepository repository;

  RemoveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tvSeriesDetail) {
    return repository.removeWatchlist(tvSeriesDetail);
  }
}