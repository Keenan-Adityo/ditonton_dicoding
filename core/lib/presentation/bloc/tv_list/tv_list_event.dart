part of 'tv_list_bloc.dart';

@immutable
abstract class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchOnAirTv extends TvListEvent {}
