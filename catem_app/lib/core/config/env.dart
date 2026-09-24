enum AppEnvironment { dev, staging, prod }

abstract final class Env {
  static const String _envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  // Solo true cuando el build trae google-services.json / GoogleService-Info.plist.
  static const bool pushEnabled = bool.fromEnvironment('PUSH_ENABLED');

  static AppEnvironment get current => AppEnvironment.values.byName(_envName);

  static bool get isProd => current == AppEnvironment.prod;

  static void validate() {
    if (supabaseUrl.isEmpty || supabasePublishableKey.isEmpty) {
      throw StateError(
        'Faltan SUPABASE_URL y/o SUPABASE_PUBLISHABLE_KEY. '
        'Corre la app con --dart-define-from-file=env/dev.json '
        '(copia env/dev.json.example).',
      );
    }
  }
}
