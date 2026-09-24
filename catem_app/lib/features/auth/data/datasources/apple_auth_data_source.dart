import 'dart:convert';

import 'package:catem_app/core/errors/exceptions.dart';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleCredential {
  const AppleCredential({required this.identityToken, required this.rawNonce});

  final String identityToken;
  final String rawNonce;
}

abstract interface class AppleAuthDataSource {
  Future<AppleCredential> signIn({required String rawNonce});

  Future<bool> isAvailable();
}

class SignInWithAppleAuthDataSource implements AppleAuthDataSource {
  const SignInWithAppleAuthDataSource();

  @override
  Future<AppleCredential> signIn({required String rawNonce}) async {
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );
    final identityToken = credential.identityToken;
    if (identityToken == null) {
      throw const ServerException('Apple no devolvio identityToken');
    }
    return AppleCredential(identityToken: identityToken, rawNonce: rawNonce);
  }

  @override
  Future<bool> isAvailable() => SignInWithApple.isAvailable();
}
