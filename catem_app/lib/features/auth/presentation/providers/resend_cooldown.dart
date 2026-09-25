import 'dart:async';

import 'package:catem_app/core/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resend_cooldown.g.dart';

/// Segundos restantes para poder reenviar el codigo/correo (rate limiting en UI).
@riverpod
class ResendCooldown extends _$ResendCooldown {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() => _timer?.cancel());
    return 0;
  }

  bool get canResend => state == 0;

  void start({int seconds = AppConstants.resendCooldownSeconds}) {
    _timer?.cancel();
    state = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        timer.cancel();
        state = 0;
      } else {
        state = state - 1;
      }
    });
  }
}
