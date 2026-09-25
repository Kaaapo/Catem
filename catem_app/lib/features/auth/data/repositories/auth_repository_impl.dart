import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/data/datasources/apple_auth_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignInException;
import 'package:sign_in_with_apple/sign_in_with_apple.dart'
    show SignInWithAppleAuthorizationException;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remote,
    this._google,
    this._apple,
    this._clearLocalCache,
  );

  final AuthRemoteDataSource _remote;
  final GoogleAuthDataSource _google;
  final AppleAuthDataSource _apple;
  final Future<void> Function() _clearLocalCache;

  @override
  Future<Result<UserEntity>> signUpWithEmail({
    required String email,
    required String password,
  }) {
    return _guard(() => _remote.signUpWithEmail(email: email, password: password));
  }

  @override
  Future<Result<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _guard(() => _remote.signInWithEmail(email: email, password: password));
  }

  @override
  Future<Result<void>> requestPhoneOtp({required String phone}) =>
      _guard(() => _remote.requestPhoneOtp(phone: phone));

  @override
  Future<Result<UserEntity>> verifyPhoneOtp({
    required String phone,
    required String code,
  }) {
    return _guard(() => _remote.verifyPhoneOtp(phone: phone, code: code));
  }

  @override
  Future<Result<UserEntity>> signInWithGoogle() => _guard(() async {
    final idToken = await _google.signIn();
    return await _remote.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  });

  @override
  Future<Result<UserEntity>> signInWithApple() => _guard(() async {
    final credential = await _apple.signIn(
      rawNonce: _remote.generateRawNonce(),
    );
    return await _remote.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: credential.identityToken,
      nonce: credential.rawNonce,
    );
  });

  @override
  Future<Result<void>> sendPasswordReset({required String email}) =>
      _guard(() => _remote.sendPasswordReset(email: email));

  @override
  Future<Result<UserEntity>> updatePassword({required String newPassword}) =>
      _guard(() => _remote.updatePassword(newPassword: newPassword));

  @override
  Future<Result<void>> resendEmailConfirmation({required String email}) =>
      _guard(() => _remote.resendEmailConfirmation(email: email));

  @override
  Future<Result<UserEntity?>> refreshCurrentUser() =>
      _guard(_remote.refreshCurrentUser);

  @override
  Future<Result<void>> signOut() => _guard(() async {
    await _remote.signOut();
    await _google.signOut();
    await _clearLocalCache();
  });

  @override
  UserEntity? get currentUser => _remote.currentUser;

  @override
  Stream<UserEntity?> get authStateChanges => _remote.authStateChanges;

  @override
  Stream<AuthEvent> get authEvents => _remote.authEvents;

  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } on GoogleSignInException catch (e) {
      return Failed(AuthFailure(e.description ?? 'Inicio con Google cancelado'));
    } on SignInWithAppleAuthorizationException catch (e) {
      return Failed(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Failed(ServerFailure(e.message));
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }
}
