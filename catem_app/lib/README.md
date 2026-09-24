# Arquitectura de `lib/`

Clean Architecture organizada **por feature**. Cada módulo del documento de requisitos es una carpeta en `features/`.

```
lib/
  main.dart                 -> bootstrap: env, Supabase.initialize, ProviderScope
  app.dart                  -> MaterialApp.router (tema + go_router)
  core/
    config/                 -> Env (variables via --dart-define)
    constants/              -> AppConstants (nombre, edad mínima, deep link scheme)
    errors/                 -> Failure (domain) y Exception (data) compartidas
    network/                -> supabaseClientProvider
    router/                 -> GoRouter y AppRoutes
    theme/                  -> ThemeData claro/oscuro
    utils/                  -> Result<T> (Success | Failed), extensiones, formatters
  features/
    auth/
      auth_providers.dart   -> composition root del feature (wiring data -> domain)
      data/
        datasources/        -> AuthRemoteDataSource (habla con supabase_flutter)
        models/             -> UserModel (extiende UserEntity, fromSupabase/fromJson)
        repositories/       -> AuthRepositoryImpl (implementa el contrato de domain)
      domain/
        entities/           -> UserEntity (Dart puro, sin Flutter ni Supabase)
        repositories/       -> AuthRepository (contrato)
        usecases/           -> SignUpUseCase, SignInUseCase, SignOutUseCase
      presentation/
        providers/          -> Riverpod providers/notifiers (usan usecases o el contrato)
        screens/
        widgets/
    home/ profile/ daily_question/ mood_tracker/ weekly_goals/
    discovery/ recommendations/ confessions/ messaging/
```

## Regla de dependencia (innegociable)

```
presentation ──> domain <── data
```

- `domain` **no importa nada** de `data` ni de `presentation`, ni de Flutter ni de Supabase.
- `data` implementa los contratos (`abstract interface class`) definidos en `domain` y es la única capa que conoce Supabase/drift.
- `presentation` solo conoce `domain`: consume usecases (o el contrato del repositorio) a través de providers. Nunca toca un datasource.
- El único archivo que conoce las tres capas es el composition root del feature (`features/<x>/<x>_providers.dart`), donde se hace el wiring con Riverpod.

Esto permite testear `domain` y los notifiers con mocks (mocktail) sin levantar Flutter ni Supabase.

## Convenciones

- Imports siempre con `package:catem_app/...` (lint `always_use_package_imports`).
- Errores: los datasources lanzan `Exception`s (`ServerException`, o las de Supabase); los repositorios las convierten en `Failure`s y devuelven `Result<T>`. Los usecases y la UI nunca ven excepciones.
- Estado: Riverpod con codegen (`@riverpod`). Modelos inmutables con `freezed` cuando tengan uniones o `copyWith`; entidades simples con `Equatable`.
- Cada feature nuevo copia la estructura de `auth/` y se registra en `core/router/app_router.dart`.

## Comandos

```bash
# Variables de entorno (una sola vez)
cp env/dev.json.example env/dev.json   # editar con las credenciales

# Generar código (riverpod, freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs   # en desarrollo

# Correr
flutter run --dart-define-from-file=env/dev.json

# Calidad
flutter analyze
flutter test --coverage
```

`env/*.json` está ignorado en git; solo se versiona `env/dev.json.example`.
