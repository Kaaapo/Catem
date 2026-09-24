import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

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
  Future<Result<void>> signOut() => _guard(_remote.signOut);

  @override
  UserEntity? get currentUser => _remote.currentUser;

  @override
  Stream<UserEntity?> get authStateChanges => _remote.authStateChanges;

  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Failed(ServerFailure(e.message));
    } on Exception catch (e) {
      return Failed(ServerFailure(e.toString()));
    }
  }
}
