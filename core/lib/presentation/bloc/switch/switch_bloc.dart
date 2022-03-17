import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchMovie()) {
    on<OnChanged>((event, emit) {
      final section = event.section;

      if (section == 'movie') {
        emit(SwitchMovie());
      } else {
        emit(SwitchTV());
      }
    });
  }
}
