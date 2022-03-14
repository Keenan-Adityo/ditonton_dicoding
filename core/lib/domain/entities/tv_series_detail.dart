import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.languages,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> episodeRunTime;
  String firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  List<String> languages;
  String name;
  dynamic nextEpisodeToAir;
  int numberOfEpisodes;
  int numberOfSeasons;
  String originalName;
  String overview;
  String posterPath;
  List<Season> seasons;
  String status;
  double voteAverage;
  int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        languages,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        seasons,
        status,
        voteAverage,
        voteCount,
      ];
}


