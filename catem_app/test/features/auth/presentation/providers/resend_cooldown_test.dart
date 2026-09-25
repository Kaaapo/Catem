import 'package:catem_app/features/auth/presentation/providers/resend_cooldown.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late ResendCooldown notifier;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    notifier = container.read(resendCooldownProvider.notifier);
  });

  int seconds() => container.read(resendCooldownProvider);

  test('arranca en 0 y cuenta hacia atras hasta permitir reenviar', () {
    fakeAsync((async) {
      expect(seconds(), 0);
      expect(notifier.canResend, isTrue);

      notifier.start(seconds: 3);
      expect(seconds(), 3);
      expect(notifier.canResend, isFalse);

      async.elapse(const Duration(seconds: 2));
      expect(seconds(), 1);

      async.elapse(const Duration(seconds: 1));
      expect(seconds(), 0);
      expect(notifier.canResend, isTrue);
    });
  });

  test('volver a llamar start reinicia el contador', () {
    fakeAsync((async) {
      notifier.start(seconds: 5);
      async.elapse(const Duration(seconds: 2));
      expect(seconds(), 3);

      notifier.start(seconds: 5);
      expect(seconds(), 5);
    });
  });
}
