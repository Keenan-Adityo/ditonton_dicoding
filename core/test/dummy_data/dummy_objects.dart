
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];
final testTVSeriesList = [testTVSeries];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: [1, 2],
  firstAirDate: '2002-05-01',
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  languages: ['languages'],
  name: 'name',
  nextEpisodeToAir: 'nextEpisodeToAir',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: '/path.jpg',
  seasons: [
    Season(
        airDate: '1',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: '/path.jpg',
        seasonNumber: 1)
  ],
  status: 'status',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTVSeries = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTVSeries = TVSeries(
  backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
  firstAirDate: '2019-06-16',
  genreIds: [18],
  id: 85552,
  name: 'Euphoria',
  originalLanguage: 'en',
  originalName: 'Euphoria',
  overview:
      'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
  popularity: 4695.201,
  posterPath: '/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg',
  voteAverage: 8.4,
  voteCount: 7136,
);
