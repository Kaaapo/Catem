# Arquitectura de `lib/`

Clean Architecture organizada **por feature**. Cada módulo del documento de requisitos es una carpeta en `features/`.

```
lib/
  main.dart                 -> bootstrap: env, Supabase.initialize, push (si PUSH_ENABLED), ProviderScope
  app.dart                  -> MaterialApp.router (tema + go_router)
  core/
    config/                 -> Env (variables via --dart-define: ENV, SUPABASE_*, GOOGLE_*, PUSH_ENABLED)
    constants/              -> AppConstants (nombre, 18+, deep link scheme, version de terminos)
    errors/                 -> Failure (domain) y Exception (data) compartidas
    local_database/         -> AppDatabase (drift) + daos/ (cache offline-first)
    network/                -> supabaseClientProvider, NetworkInfo (connectivity_plus)
    router/                 -> GoRouter, AppRoutes, AuthRedirect, StreamListenable
    theme/                  -> ThemeData claro/oscuro
    utils/                  -> Result<T> (Success | Failed), AgeValidator
    widgets/                -> AppButton, PendingMockupScreen (componentes base)
  features/
    auth/
      auth_providers.dart   -> composition root del feature (wiring data -> domain)
      data/
        datasources/        -> AuthRemoteDataSource (Supabase), GoogleAuthDataSource, AppleAuthDataSource
        models/             -> UserModel (extiende UserEntity, fromSupabase/fromJson)
        repositories/       -> AuthRepositoryImpl (mapea excepciones a Failure)
      domain/
        entities/           -> UserEntity, AuthEvent (Dart puro, sin Flutter ni Supabase)
        repositories/       -> AuthRepository (contrato)
        usecases/           -> SignUp/SignIn/SignOut, RequestPhoneOtp, VerifyPhoneOtp,
                               SignInWithGoogle/Apple, SendPasswordReset, UpdatePassword,
                               ResendEmailConfirmation, RefreshCurrentUser, ValidateMinimumAge
      presentation/
        providers/          -> authState, authEvents, AuthController, ResendCooldown
        screens/ widgets/   -> (pendientes de mockups: CATEM-74/75)
    profile/                -> ProfileEntity/Model, ProfileRepositoryImpl cache-first,
                               ProfileLocal/RemoteDataSource, AvatarRemoteDataSource,
                               GetProfile/AcceptConsent usecases
    notifications/          -> FCM: FcmRemoteDataSource, DeviceTokenRemoteDataSource,
                               PushNotificationsRepositoryImpl, RegisterDeviceForPush, push_bootstrap
    home/                   -> HomeScreen (placeholder)
    daily_question/ mood_tracker/ weekly_goals/ discovery/
    recommendations/ confessions/ messaging/   -> (ciclos 3-5)
```

## Regla de dependencia (innegociable)

```
presentation ──> domain <── data
```

- `domain` **no importa nada** de `data` ni de `presentation`, ni de Flutter ni de Supabase.
- `data` implementa los contratos (`abstract interface class`) definidos en `domain` y es la única capa que conoce Supabase/drift/Firebase/Google.
- `presentation` solo conoce `domain`: consume usecases (o el contrato del repositorio) a través de providers. Nunca toca un datasource.
- El único archivo que conoce las tres capas es el composition root del feature (`features/<x>/<x>_providers.dart`), donde se hace el wiring con Riverpod.

Esto permite testear `domain` y los notifiers con mocks (mocktail) sin levantar Flutter ni Supabase.

## Flujo de navegación (CATEM-22)

`AuthRedirect` (en `core/router/app_router.dart`) se evalúa en cada cambio de sesión:

1. Sin sesión → `/auth/login` (se permite navegar dentro de `/auth/*`).
2. Evento `passwordRecovery` (deep link de reset) → `/reset-password` hasta cambiar la contraseña.
3. Sesión sin email/teléfono verificado → `/auth/verify`.
4. Perfil sin `nick_publico`, `fecha_nacimiento` o consentimiento de la versión vigente → `/onboarding`.
5. Todo completo → `/`.

## Convenciones

- Imports siempre con `package:catem_app/...` (lint `always_use_package_imports`).
- Errores: los datasources lanzan `Exception`s (`ServerException`, o las de Supabase); los repositorios las convierten en `Failure`s y devuelven `Result<T>`. Los usecases y la UI nunca ven excepciones.
- Estado: Riverpod con codegen (`@riverpod`). Acciones de auth vía `AuthController` (AsyncNotifier). Modelos inmutables con `freezed` cuando tengan uniones o `copyWith`; entidades simples con `Equatable`.
- Offline-first (RNF-07): los repositorios leen primero de drift (`AppDatabase`) y sincronizan en background si `NetworkInfo.isConnected`.
- Cada feature nuevo copia la estructura de `auth/` y se registra en `core/router/app_router.dart`.
- Pantallas provisionales: `PendingMockupScreen` hasta tener los mockups; la UI real se construye sobre los componentes de `core/widgets/` y los tokens del `ThemeData`.

## Tests (`test/` espeja `lib/`)

- `test/helpers/pump_app.dart`: `tester.pumpApp(widget, overrides: [...])` envuelve con `ProviderScope` + `MaterialApp`.
- `test/helpers/mocks.dart`: mocks mocktail de repositorios, datasources y `NetworkInfo`.
- `test/helpers/fake_supabase.dart`: `FakeSupabase` crea un `SupabaseClient` real sobre `http.MockClient`; permite probar datasources (auth, Postgrest, Storage) sin red y verificar los requests (`fake.on(...)`, `fake.requestTo(...)`).
- drift se prueba con `AppDatabase(NativeDatabase.memory())`.
- Umbral de cobertura: 70 % en `domain` y `data` (`tool/check_coverage.py`, `run_tests.sh`).

## Comandos

```bash
# Variables de entorno (una sola vez)
cp env/dev.json.example env/dev.json   # editar con las credenciales

# Generar código (riverpod, freezed, json_serializable, drift)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs   # en desarrollo

# Correr
flutter run --dart-define-from-file=env/dev.json

# Calidad
flutter analyze
./run_tests.sh            # flutter test --coverage + umbral 70 %
```

`env/*.json` está ignorado en git; solo se versiona `env/dev.json.example`.
