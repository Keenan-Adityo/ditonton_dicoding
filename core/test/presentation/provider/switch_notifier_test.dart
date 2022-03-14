import 'package:core/presentation/provider/switch_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SwitchNotifier notifier;

  setUp(
    () {
      notifier = SwitchNotifier();
    },
  );
  group(
    'switch beetwen tv and movie',
    () {
      test(
        'Should return movie when open the app',
        () {
          expect(notifier.data, 'movie');
        },
      );
      test(
        'Should change to tv when change from movie',
        () {
          notifier.changeTV();
          expect(notifier.data, 'tv');
        },
      );
      test(
        'Should change to movie when change from tv',
        () {
          notifier.changeMovie();
          expect(notifier.data, 'movie');
        },
      );
    },
  );
}
