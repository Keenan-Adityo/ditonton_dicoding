import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


class SaveWatchlistTV {
  final TVSeriesRepository repository;

  SaveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tvSeriesDetail) {
    return repository.saveWatchlist(tvSeriesDetail);
  }
}