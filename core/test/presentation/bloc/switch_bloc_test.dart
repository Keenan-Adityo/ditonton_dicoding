import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/switch/switch_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SwitchBloc bloc;

  setUp(
    () {
      bloc = SwitchBloc();
    },
  );

  test(
    'Should return SwitchMovie state when first initalized',
    () {
      expect(bloc.state, SwitchMovie());
    },
  );

  blocTest<SwitchBloc, SwitchState>(
    'Should change to SwitchTv state when changed',
    build: () {
      return bloc;
    },
    act: (bloc) => bloc.add(const OnChanged('tv')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SwitchTV(),
    ],
  );

  blocTest<SwitchBloc, SwitchState>(
    'Should change to SwitchMovie state when changed',
    build: () {
      return bloc;
    },
    act: (bloc) => bloc.add(const OnChanged('movie')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SwitchMovie(),
    ],
  );
}
