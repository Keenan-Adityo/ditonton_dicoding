import 'dart:io';

import 'package:core/common/network_info.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/models/tv_series_table.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource remoteDataSource;
  final TVSeriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TVSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<TVSeries>>> getOnAirTV() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnAirTV();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      } on TlsException catch (e) {
        return const Left(CommonFailure('Certificated not valid\n'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCachedOnTheAirTVSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTV() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTV();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      } on TlsException catch (e) {
        return const Left(CommonFailure('Certificated not valid\n'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCachedPopularTVSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTV() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTV();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      } on TlsException catch (e) {
        return const Left(CommonFailure('Certificated not valid\n'));
      } catch (e) {
        return Left(CommonFailure(e.toString()));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopRatedTVSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return const Left(CommonFailure('Certificated not valid\n'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return const Left(CommonFailure('Certificated not valid\n'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return const Left(CommonFailure('Certificated not valid\n'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tv) async {
    try {
      final result =
          await localDataSource.insertTVWatchlist(TVSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tv) async {
    try {
      final result =
          await localDataSource.removeTVWatchlist(TVSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries() async {
    final result = await localDataSource.getWatchlistTVSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTVSeriesById(id);
    return result != null;
  }
}
