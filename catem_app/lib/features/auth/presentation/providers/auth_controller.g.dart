// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Estado de la accion de auth en curso: loading mientras corre, error con el
/// Failure si fallo, data(null) si termino bien. La navegacion la decide el router.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// Estado de la accion de auth en curso: loading mientras corre, error con el
/// Failure si fallo, data(null) si termino bien. La navegacion la decide el router.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, void> {
  /// Estado de la accion de auth en curso: loading mientras corre, error con el
  /// Failure si fallo, data(null) si termino bien. La navegacion la decide el router.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'edee79f19c733fa1c9d5ad46e40ca05466af670e';

/// Estado de la accion de auth en curso: loading mientras corre, error con el
/// Failure si fallo, data(null) si termino bien. La navegacion la decide el router.

abstract class _$AuthController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
