import 'package:catem_app/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class GoogleAuthDataSource {
  /// Devuelve el idToken de Google para intercambiarlo en Supabase.
  Future<String> signIn();

  Future<void> signOut();
}

class GoogleSignInAuthDataSource implements GoogleAuthDataSource {
  GoogleSignInAuthDataSource(
    this._webClientId,
    this._iosClientId, {
    GoogleSignIn? googleSignIn,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final String _webClientId;
  final String? _iosClientId;
  final GoogleSignIn _googleSignIn;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    if (_webClientId.isEmpty) {
      throw const ServerException(
        'Falta GOOGLE_WEB_CLIENT_ID (--dart-define) para iniciar sesion con Google',
      );
    }
    await _googleSignIn.initialize(
      clientId: _iosClientId,
      serverClientId: _webClientId,
    );
    _initialized = true;
  }

  @override
  Future<String> signIn() async {
    await _ensureInitialized();
    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const ServerException('Google no devolvio idToken');
    }
    return idToken;
  }

  @override
  Future<void> signOut() async {
    if (!_initialized) return;
    await _googleSignIn.signOut();
  }
}
