import 'dart:async';

import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// Estado de la accion de auth en curso: loading mientras corre, error con el
/// Failure si fallo, data(null) si termino bien. La navegacion la decide el router.
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
  }) {
    return _run(
      () => ref.read(signUpUseCaseProvider)(email: email, password: password),
    );
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _run(
      () => ref.read(signInUseCaseProvider)(email: email, password: password),
    );
  }

  Future<bool> signInWithGoogle() =>
      _run(() => ref.read(signInWithGoogleUseCaseProvider)());

  Future<bool> signInWithApple() =>
      _run(() => ref.read(signInWithAppleUseCaseProvider)());

  Future<bool> requestPhoneOtp({required String phone}) =>
      _run(() => ref.read(requestPhoneOtpUseCaseProvider)(phone: phone));

  Future<bool> verifyPhoneOtp({required String phone, required String code}) {
    return _run(
      () => ref.read(verifyPhoneOtpUseCaseProvider)(phone: phone, code: code),
    );
  }

  Future<bool> sendPasswordReset({required String email}) =>
      _run(() => ref.read(sendPasswordResetUseCaseProvider)(email: email));

  Future<bool> updatePassword({required String newPassword}) {
    return _run(
      () => ref.read(updatePasswordUseCaseProvider)(newPassword: newPassword),
    );
  }

  Future<bool> resendEmailConfirmation({required String email}) {
    return _run(
      () => ref.read(resendEmailConfirmationUseCaseProvider)(email: email),
    );
  }

  Future<bool> refreshCurrentUser() =>
      _run(() => ref.read(refreshCurrentUserUseCaseProvider)());

  Future<bool> signOut() => _run(() => ref.read(signOutUseCaseProvider)());

  Future<bool> _run(Future<Result<Object?>> Function() action) async {
    state = const AsyncLoading();
    final result = await action();
    switch (result) {
      case Success():
        state = const AsyncData(null);
        return true;
      case Failed(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return false;
    }
  }
}
