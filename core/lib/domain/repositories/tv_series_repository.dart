import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnAirTV();
  Future<Either<Failure, List<TVSeries>>> getPopularTV();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTV();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
}
