# Catem

App social móvil (Flutter + Supabase). Gestión del proyecto en Plane: https://app.plane.so/katchdev/projects/dc693b9f-37b9-4abe-ae36-c13cbdc44185/issues

| Carpeta | Qué es | Doc |
|---|---|---|
| `catem_app/` | App Flutter (Clean Architecture por feature, Riverpod, go_router, drift, supabase_flutter, FCM) | [`catem_app/lib/README.md`](catem_app/lib/README.md) |
| `supabase/` | Esquema versionado (migraciones), config de auth/storage, stack local con Docker | [`supabase/README.md`](supabase/README.md) |
| `.github/workflows/` | CI: analyze + test + cobertura en cada PR; builds Android/iOS en main | — |

## Setup del entorno (guía para el equipo)

Tiempo estimado: 30–45 min la primera vez (la mayoría es descarga de imágenes Docker, SDK de Android y pods de iOS).

### 1. Herramientas

| Herramienta | Instalación (macOS) | Nota |
|---|---|---|
| Flutter 3.x stable | `brew install --cask flutter` o https://docs.flutter.dev/get-started/install | Verificar con `flutter doctor`. Usamos 3.47+. |
| Xcode + CocoaPods | App Store + `sudo gem install cocoapods` | Solo para iOS. |
| JDK 17 + Android SDK | `brew install openjdk@17` y `brew install --cask android-commandlinetools`, luego `sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"` y `flutter config --android-sdk $ANDROID_HOME --jdk-dir $JAVA_HOME` | Alternativa: Android Studio. Ver variables de entorno abajo. |
| Docker Desktop | `brew install --cask docker-desktop` | Requiere contraseña de admin. En Apple Silicon, si no arranca por "Failed to install Rosetta": Settings > General > desmarcar *Use Rosetta for x86_64/amd64 emulation*. |
| Supabase CLI | `brew install supabase/tap/supabase` | Luego `supabase login` (abre el navegador; usar la cuenta del proyecto). |
| Node + Firebase CLI + FlutterFire (solo para CATEM-18) | `brew install node && npm i -g firebase-tools && dart pub global activate flutterfire_cli` | Se usan cuando exista el proyecto Firebase. |
| GitHub CLI (opcional) | `brew install gh` → `gh auth login` → `gh auth setup-git` | Para push/PRs por HTTPS sin configurar tokens a mano. |
| actionlint (opcional) | `brew install actionlint` | Valida `.github/workflows/*.yml` antes de subirlos. |

Variables de entorno en `~/.zshrc` (ajustar rutas si no usas Homebrew):

```bash
export JAVA_HOME="$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home"
export ANDROID_HOME="$(brew --prefix)/share/android-commandlinetools"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$HOME/.pub-cache/bin"
```

### 1b. Herramientas en Windows

En Windows solo se compila **Android** (iOS requiere macOS + Xcode); el CI se encarga de los builds de iOS. Abre PowerShell **como usuario normal** (no admin) salvo donde se indique.

| Herramienta | Instalación (PowerShell) | Nota |
|---|---|---|
| Git | `winget install --id Git.Git` | Al terminar: `git config --global core.autocrlf true` y `git config --global core.longpaths true` (los builds de Android superan el límite de 260 caracteres). |
| Modo desarrollador | `start ms-settings:developers` → activar *Developer Mode* | Obligatorio: Flutter necesita symlinks para los plugins. |
| Flutter 3.x stable | Descargar el zip de https://docs.flutter.dev/get-started/install/windows y extraer en `C:\src\flutter` (sin espacios ni caracteres especiales) → agregar `C:\src\flutter\bin` al PATH del usuario | Verificar con `flutter doctor`. No instalar en `C:\Program Files`. |
| Android Studio | https://developer.android.com/studio | Incluye JDK y SDK. En el SDK Manager instalar *Android SDK Platform 36*, *Build-Tools 36*, *Platform-Tools*, *Emulator* y crear un emulador (Pixel). Luego `flutter doctor --android-licenses`. |
| Docker Desktop (WSL 2) | 1) PowerShell **como admin**: `wsl --install` y reiniciar. 2) `winget install --id Docker.DockerDesktop` | En Settings > General dejar *Use the WSL 2 based engine*. Requiere virtualización activa en la BIOS. |
| Scoop + Supabase CLI | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` → `irm get.scoop.sh \| iex` → `scoop bucket add supabase https://github.com/supabase/scoop-bucket.git` → `scoop install supabase` | Luego `supabase login` (abre el navegador). No usar `npm i -g supabase`, no está soportado. |
| Node + Firebase CLI + FlutterFire (solo CATEM-18) | `winget install --id OpenJS.NodeJS.LTS` → `npm i -g firebase-tools` → `dart pub global activate flutterfire_cli` | Agregar `%LOCALAPPDATA%\Pub\Cache\bin` al PATH. |
| GitHub CLI (opcional) | `winget install --id GitHub.cli` → `gh auth login` | Configura las credenciales de git automáticamente. |

Cierra y vuelve a abrir PowerShell después de cambiar el PATH. `flutter doctor` debe mostrar Flutter, Android toolchain y Android Studio en verde (Chrome y Visual Studio pueden quedar en rojo, no se usan).

Si Flutter no encuentra el JDK: `flutter config --jdk-dir "C:\Program Files\Android\Android Studio\jbr"`. Si no encuentra el SDK: `flutter config --android-sdk "$env:LOCALAPPDATA\Android\Sdk"`.

### 2. Clonar y levantar el backend local

```bash
git clone https://github.com/Kaaapo/Catem.git && cd Catem
git checkout develop
supabase start      # primera vez: descarga ~2 GB de imágenes
supabase db reset   # aplica todas las migraciones desde cero
supabase status     # imprime API URL y keys locales
```

Servicios locales: API `http://127.0.0.1:54321` · Studio `http://127.0.0.1:54323` · Mailpit (correos de auth) `http://127.0.0.1:54324` · Postgres `127.0.0.1:54322` (user/pass `postgres`).

Los mismos comandos funcionan en PowerShell (Docker Desktop debe estar abierto y con el motor WSL 2 corriendo antes de `supabase start`).

### 3. Configurar y correr la app

```bash
cd catem_app
cp env/dev.json.example env/dev.json
# editar env/dev.json: SUPABASE_URL = API URL y SUPABASE_PUBLISHABLE_KEY = publishable/anon key de `supabase status`
# (emulador Android: usar http://10.0.2.2:54321)
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera *.g.dart (riverpod, json, drift)
flutter run --dart-define-from-file=env/dev.json
```

`env/dev.json` está en `.gitignore`; nunca se commitea. Otras variables opcionales del mismo archivo: `GOOGLE_WEB_CLIENT_ID`, `GOOGLE_IOS_CLIENT_ID` (login con Google) y `PUSH_ENABLED=true` (solo cuando el build incluya `google-services.json` / `GoogleService-Info.plist`). Para apuntar al proyecto cloud, crear `env/staging.json` con la URL y publishable key del dashboard.

### 4. Verificar

```bash
flutter analyze          # debe decir "No issues found"
./run_tests.sh           # flutter test --coverage + umbral 70 % en domain/data
```

En Windows: `cp` es `Copy-Item env\dev.json.example env\dev.json` y el script de tests es `.\run_tests.ps1` (requiere Python 3 en el PATH: `winget install --id Python.Python.3.12`).

## Flujo de trabajo

**Ramas**
- `main`: releases. Solo recibe PRs desde `develop`.
- `develop`: integración. Recibe PRs desde ramas de feature.
- Ramas de trabajo: `feature/CATEM-<n>-descripcion-corta` creadas desde `develop`. Una rama por ticket (o por grupo pequeño de tickets relacionados).

**Ciclo de un ticket**
1. En Plane: asignarse el ticket y pasarlo a **In Progress** (poner `start_date`).
2. Crear la rama, implementar, correr `flutter analyze` + `./run_tests.sh`.
3. Si hay cambios de esquema: `supabase migration new <nombre>`, escribir el SQL, probar con `supabase db reset`. Toda tabla nueva nace con `enable row level security`.
4. Abrir PR contra `develop` con resumen + test plan; enlazar el PR en un comentario del ticket. El CI corre analyze + test + cobertura.
5. Al mergear: ticket a **Done**. Quien mergea a `develop` corre `supabase db push` / `supabase config push` si el PR trae migraciones o cambios de `config.toml`.

**Reglas**
- Nada de secretos en el repo (`service_role`/`secret` key jamás en la app; la publishable/anon sí puede ir en el cliente). Los secretos de CI van en GitHub Secrets (`ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`).
- El esquema de la base se cambia solo por migraciones, nunca desde el dashboard.
- Imports con `package:catem_app/...`; regla de dependencia de Clean Architecture en [`catem_app/lib/README.md`](catem_app/lib/README.md).
- Los `*.g.dart` se commitean; el CI falla si están desactualizados.
- Estados en Plane: `Backlog` (bloqueado o sin priorizar) → `Todo` (listo para tomar) → `In Progress` → `Done`.

**Pendiente del dueño del repo (Kaaapo):** en Settings > Branches proteger `develop` y `main` con *Require a pull request before merging* y *Require status checks to pass* (check `Analyze & test`). Sin esto el CI corre pero no bloquea el merge.

## Estado del Ciclo 1 – Fundación (2026-09-24 → 2026-10-08)

| Ticket | Estado | Notas |
|---|---|---|
| CATEM-14 Setup proyecto Flutter | Done | PR #1 |
| CATEM-19 Arquitectura de carpetas | Done | PR #1, feature `auth` como plantilla |
| CATEM-16 Docker / entorno local | Done | `supabase start` + `db reset` documentados |
| CATEM-17 CI/CD | Done | GitHub Actions; falta protección de ramas (admin) |
| CATEM-20 Cache local (drift) | Done | `AppDatabase`, DAO, cache-first en `profile` |
| CATEM-80 Buckets de Storage | Done | Migración con RLS + `AvatarRemoteDataSource` |
| CATEM-81 Suite de tests | Done | 106 tests; domain 85 %, data 79 % |
| CATEM-15 Setup proyecto Supabase | In Progress | Migraciones y auth config aplicadas en cloud. Falta invitar al equipo desde el dashboard. |
| CATEM-18 FCM | In Progress | Código, tabla `device_tokens` y permisos nativos listos. Falta crear el proyecto Firebase (`flutterfire configure`) y la APNs key. |
| CATEM-21 Registro | In Progress | Email listo; OTP/Google/Apple codificados pero requieren Twilio, Google Cloud y Apple Developer. UI pendiente de mockups. |
| CATEM-22 Login y sesión | In Progress | Lógica + router listos. UI pendiente de mockups. |
| CATEM-23 Recuperar contraseña | In Progress | Lógica + deep links listos. UI pendiente de mockups. |
| CATEM-24 Verificación | In Progress | Gate + OTP + cooldown listos. UI pendiente de mockups. |
| CATEM-25 Consentimiento | In Progress | Textos v1.0 (revisar con legal) + usecase + DB. UI pendiente de mockups. |
| CATEM-99 Edad mínima 18+ | In Progress | Validador + check en DB listos. Date picker pendiente de mockups. |
| CATEM-74, 75 Figma | Backlog | Omitidos: requieren trabajo de diseño en Figma. |

Decisiones tomadas:
- Región de Supabase: se mantiene **us-east-2 (Ohio)**; la latencia desde Colombia es igual o mejor que São Paulo y no se puede cambiar sin recrear el proyecto.
- Catem es **18+** (CATEM-99): validación exacta por fecha de nacimiento en la app y check en la base de datos.
- Se quitaron `custom_lint`/`riverpod_lint` del proyecto Flutter porque fijaban una versión vieja del analyzer.
- Los archivos generados (`*.g.dart`) se commitean para que el CI no dependa de `build_runner`.
- El `config.toml` de Supabase se sincroniza con `supabase config pull` antes de editar, para no pisar la configuración remota.
- Las pantallas de auth/onboarding son `PendingMockupScreen` hasta tener los mockups; la lógica (providers, router, usecases) ya está completa y probada.
