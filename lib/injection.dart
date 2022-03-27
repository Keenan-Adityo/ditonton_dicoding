import 'package:core/common/network_info.dart';
import 'package:core/common/sslpinning.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_on_air_tv.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/switch/switch_bloc.dart';
import 'package:core/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv/searchtv_bloc.dart';
import 'package:search/search.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SwitchBloc(),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => OnAirTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMovieListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      getTVDetail: locator(),
      getTVRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );


  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetOnAirTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator(),));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
