part of 'searchtv_bloc.dart';

@immutable
abstract class SearchTVEvent extends Equatable {
  const SearchTVEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTV extends SearchTVEvent {
  final String query;

  const OnQueryChangedTV(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
