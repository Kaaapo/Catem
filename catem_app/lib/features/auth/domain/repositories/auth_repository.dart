import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Result<UserEntity>> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Envia un codigo OTP por SMS (crea la cuenta si no existe).
  Future<Result<void>> requestPhoneOtp({required String phone});

  Future<Result<UserEntity>> verifyPhoneOtp({
    required String phone,
    required String code,
  });

  Future<Result<UserEntity>> signInWithGoogle();

  Future<Result<UserEntity>> signInWithApple();

  Future<Result<void>> sendPasswordReset({required String email});

  Future<Result<UserEntity>> updatePassword({required String newPassword});

  Future<Result<void>> resendEmailConfirmation({required String email});

  Future<Result<UserEntity?>> refreshCurrentUser();

  Future<Result<void>> signOut();

  UserEntity? get currentUser;

  Stream<UserEntity?> get authStateChanges;

  Stream<AuthEvent> get authEvents;
}
