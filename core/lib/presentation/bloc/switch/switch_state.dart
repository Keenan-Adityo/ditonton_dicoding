part of 'switch_bloc.dart';

@immutable
abstract class SwitchState extends Equatable {
  const SwitchState();

  @override
  List<Object> get props => [];
}

class SwitchMovie extends SwitchState {}

class SwitchTV extends SwitchState {}
