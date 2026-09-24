import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();

  UserModel? get currentUser;

  Stream<UserModel?> get authStateChanges;
}

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  const SupabaseAuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return _requireUser(response.user);
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return _requireUser(response.user);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  UserModel? get currentUser {
    final user = _client.auth.currentUser;
    return user == null ? null : UserModel.fromSupabase(user);
  }

  @override
  Stream<UserModel?> get authStateChanges =>
      _client.auth.onAuthStateChange.map((state) {
        final user = state.session?.user;
        return user == null ? null : UserModel.fromSupabase(user);
      });

  UserModel _requireUser(User? user) {
    if (user == null) {
      throw const ServerException('Supabase no devolvio un usuario');
    }
    return UserModel.fromSupabase(user);
  }
}
