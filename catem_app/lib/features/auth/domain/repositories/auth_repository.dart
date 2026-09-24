import 'package:catem_app/core/utils/result.dart';
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

  Future<Result<void>> signOut();

  UserEntity? get currentUser;

  Stream<UserEntity?> get authStateChanges;
}
