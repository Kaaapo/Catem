import 'package:catem_app/core/constants/app_constants.dart';
import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/features/auth/data/models/user_model.dart';
import 'package:catem_app/features/auth/domain/entities/auth_event.dart';
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

  Future<void> requestPhoneOtp({required String phone});

  Future<UserModel> verifyPhoneOtp({required String phone, required String code});

  Future<UserModel> signInWithIdToken({
    required OAuthProvider provider,
    required String idToken,
    String? accessToken,
    String? nonce,
  });

  String generateRawNonce();

  Future<void> sendPasswordReset({required String email});

  Future<UserModel> updatePassword({required String newPassword});

  Future<void> resendEmailConfirmation({required String email});

  Future<UserModel?> refreshCurrentUser();

  Future<void> signOut();

  UserModel? get currentUser;

  Stream<UserModel?> get authStateChanges;

  Stream<AuthEvent> get authEvents;
}

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  const SupabaseAuthRemoteDataSource(this._client);

  static const _callbackBase =
      '${AppConstants.authCallbackScheme}://${AppConstants.authCallbackHost}';
  static const resetPasswordRedirect = '$_callbackBase/reset-password';
  static const verifyEmailRedirect = '$_callbackBase/verify-email';

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: verifyEmailRedirect,
    );
    return _requireUser(response.user);
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _auth.signInWithPassword(
      email: email,
      password: password,
    );
    return _requireUser(response.user);
  }

  @override
  Future<void> requestPhoneOtp({required String phone}) =>
      _auth.signInWithOtp(phone: phone);

  @override
  Future<UserModel> verifyPhoneOtp({
    required String phone,
    required String code,
  }) async {
    final response = await _auth.verifyOTP(
      phone: phone,
      token: code,
      type: OtpType.sms,
    );
    return _requireUser(response.user);
  }

  @override
  Future<UserModel> signInWithIdToken({
    required OAuthProvider provider,
    required String idToken,
    String? accessToken,
    String? nonce,
  }) async {
    final response = await _auth.signInWithIdToken(
      provider: provider,
      idToken: idToken,
      accessToken: accessToken,
      nonce: nonce,
    );
    return _requireUser(response.user);
  }

  @override
  String generateRawNonce() => _auth.generateRawNonce();

  @override
  Future<void> sendPasswordReset({required String email}) =>
      _auth.resetPasswordForEmail(email, redirectTo: resetPasswordRedirect);

  @override
  Future<UserModel> updatePassword({required String newPassword}) async {
    final response = await _auth.updateUser(UserAttributes(password: newPassword));
    return _requireUser(response.user);
  }

  @override
  Future<void> resendEmailConfirmation({required String email}) => _auth.resend(
    type: OtpType.signup,
    email: email,
    emailRedirectTo: verifyEmailRedirect,
  );

  @override
  Future<UserModel?> refreshCurrentUser() async {
    if (_auth.currentSession == null) return null;
    final response = await _auth.getUser();
    final user = response.user;
    return user == null ? null : UserModel.fromSupabase(user);
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  UserModel? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : UserModel.fromSupabase(user);
  }

  @override
  Stream<UserModel?> get authStateChanges => _auth.onAuthStateChange.map((state) {
    final user = state.session?.user;
    return user == null ? null : UserModel.fromSupabase(user);
  });

  @override
  Stream<AuthEvent> get authEvents => _auth.onAuthStateChange.map(
    (state) => switch (state.event) {
      AuthChangeEvent.signedIn => AuthEvent.signedIn,
      AuthChangeEvent.signedOut => AuthEvent.signedOut,
      AuthChangeEvent.passwordRecovery => AuthEvent.passwordRecovery,
      AuthChangeEvent.userUpdated => AuthEvent.userUpdated,
      _ => AuthEvent.other,
    },
  );

  UserModel _requireUser(User? user) {
    if (user == null) {
      throw const ServerException('Supabase no devolvio un usuario');
    }
    return UserModel.fromSupabase(user);
  }
}
