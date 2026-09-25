abstract final class AppConstants {
  static const String appName = 'Catem';
  static const int minimumAge = 18;
  // Version de los documentos en assets/legal/. Subirla obliga a re-aceptar el consentimiento.
  static const String termsVersion = '1.0';
  static const String termsAssetPath = 'assets/legal/terminos_v1.0.md';
  static const String privacyAssetPath = 'assets/legal/privacidad_v1.0.md';
  static const String authCallbackScheme = 'catem';
  static const String authCallbackHost = 'auth-callback';
  static const int resendCooldownSeconds = 60;
}
