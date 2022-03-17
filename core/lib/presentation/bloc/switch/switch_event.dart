part of 'switch_bloc.dart';

@immutable
abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class OnChanged extends SwitchEvent {
  final String section;

  const OnChanged(this.section);

  @override
  List<Object> get props => [section];
}
