// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_cooldown.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Segundos restantes para poder reenviar el codigo/correo (rate limiting en UI).

@ProviderFor(ResendCooldown)
final resendCooldownProvider = ResendCooldownProvider._();

/// Segundos restantes para poder reenviar el codigo/correo (rate limiting en UI).
final class ResendCooldownProvider
    extends $NotifierProvider<ResendCooldown, int> {
  /// Segundos restantes para poder reenviar el codigo/correo (rate limiting en UI).
  ResendCooldownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resendCooldownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resendCooldownHash();

  @$internal
  @override
  ResendCooldown create() => ResendCooldown();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$resendCooldownHash() => r'552a3c014a7fdd30470273a72bfe220a706c1e09';

/// Segundos restantes para poder reenviar el codigo/correo (rate limiting en UI).

abstract class _$ResendCooldown extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
