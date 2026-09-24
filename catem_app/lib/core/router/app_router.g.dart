// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRedirect)
final authRedirectProvider = AuthRedirectProvider._();

final class AuthRedirectProvider
    extends $FunctionalProvider<AuthRedirect, AuthRedirect, AuthRedirect>
    with $Provider<AuthRedirect> {
  AuthRedirectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRedirectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRedirectHash();

  @$internal
  @override
  $ProviderElement<AuthRedirect> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRedirect create(Ref ref) {
    return authRedirect(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRedirect value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRedirect>(value),
    );
  }
}

String _$authRedirectHash() => r'd40823cc1b26c9aab803e9b4eb96fe5df59713c5';

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'66df3c3a45c2a0e8ed97d605f9d6b9c9ce624526';
