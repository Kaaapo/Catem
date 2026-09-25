// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Usuario actual; supabase_flutter emite la sesion persistida al suscribirse.

@ProviderFor(authState)
final authStateProvider = AuthStateProvider._();

/// Usuario actual; supabase_flutter emite la sesion persistida al suscribirse.

final class AuthStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserEntity?>,
          UserEntity?,
          Stream<UserEntity?>
        >
    with $FutureModifier<UserEntity?>, $StreamProvider<UserEntity?> {
  /// Usuario actual; supabase_flutter emite la sesion persistida al suscribirse.
  AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  $StreamProviderElement<UserEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<UserEntity?> create(Ref ref) {
    return authState(ref);
  }
}

String _$authStateHash() => r'015036670a6cf1c11077e723aa4cd304e306ae2a';

@ProviderFor(authEvents)
final authEventsProvider = AuthEventsProvider._();

final class AuthEventsProvider
    extends
        $FunctionalProvider<AsyncValue<AuthEvent>, AuthEvent, Stream<AuthEvent>>
    with $FutureModifier<AuthEvent>, $StreamProvider<AuthEvent> {
  AuthEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authEventsHash();

  @$internal
  @override
  $StreamProviderElement<AuthEvent> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AuthEvent> create(Ref ref) {
    return authEvents(ref);
  }
}

String _$authEventsHash() => r'b9436de2f06f84a85d5cbe6c2cc121630047eb4d';
