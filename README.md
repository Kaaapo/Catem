# Catem

App social móvil (Flutter + Supabase). Gestión del proyecto en Plane: https://app.plane.so/katchdev/projects/dc693b9f-37b9-4abe-ae36-c13cbdc44185/issues

| Carpeta | Qué es | Doc |
|---|---|---|
| `catem_app/` | App Flutter (Clean Architecture por feature, Riverpod, go_router, supabase_flutter) | [`catem_app/lib/README.md`](catem_app/lib/README.md) |
| `supabase/` | Esquema versionado (migraciones), config de auth/storage, stack local con Docker | [`supabase/README.md`](supabase/README.md) |

## Setup del entorno (guía para el equipo)

Tiempo estimado: 20–30 min la primera vez (la mayoría es descarga de imágenes Docker y pods de iOS).

### 1. Herramientas

| Herramienta | Instalación (macOS) | Nota |
|---|---|---|
| Flutter 3.x stable | `brew install --cask flutter` o https://docs.flutter.dev/get-started/install | Verificar con `flutter doctor`. Usamos 3.47+. |
| Xcode + CocoaPods | App Store + `sudo gem install cocoapods` | Solo para iOS. |
| Android Studio | https://developer.android.com/studio | Instalar SDK + un emulador. `flutter doctor --android-licenses`. |
| Docker Desktop | `brew install --cask docker-desktop` | Requiere contraseña de admin. En Apple Silicon, si no arranca por "Failed to install Rosetta": Settings > General > desmarcar *Use Rosetta for x86_64/amd64 emulation*. |
| Supabase CLI | `brew install supabase/tap/supabase` | Luego `supabase login` (abre el navegador; usar la cuenta del proyecto). |
| GitHub CLI (opcional) | `brew install gh` → `gh auth login` → `gh auth setup-git` | Para push/PRs por HTTPS sin configurar tokens a mano. |

### 2. Clonar y levantar el backend local

```bash
git clone https://github.com/Kaaapo/Catem.git && cd Catem
git checkout develop
supabase start      # primera vez: descarga ~2 GB de imágenes
supabase db reset   # aplica todas las migraciones desde cero
supabase status     # imprime API URL y keys locales
```

Servicios locales: API `http://127.0.0.1:54321` · Studio `http://127.0.0.1:54323` · Mailpit (correos de auth) `http://127.0.0.1:54324` · Postgres `127.0.0.1:54322` (user/pass `postgres`).

### 3. Configurar y correr la app

```bash
cd catem_app
cp env/dev.json.example env/dev.json
# editar env/dev.json: SUPABASE_URL = API URL y SUPABASE_PUBLISHABLE_KEY = publishable/anon key de `supabase status`
# (emulador Android: usar http://10.0.2.2:54321)
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # genera *.g.dart (riverpod, json)
flutter run --dart-define-from-file=env/dev.json
```

`env/dev.json` está en `.gitignore`; nunca se commitea. Para apuntar al proyecto cloud, crear `env/staging.json` con la URL y publishable key del dashboard.

### 4. Verificar

```bash
flutter analyze          # debe decir "No issues found"
flutter test             # todos en verde
```

## Flujo de trabajo

**Ramas**
- `main`: releases. Solo recibe PRs desde `develop`.
- `develop`: integración. Recibe PRs desde ramas de feature.
- Ramas de trabajo: `feature/CATEM-<n>-descripcion-corta` creadas desde `develop`. Una rama por ticket (o por grupo pequeño de tickets relacionados).

**Ciclo de un ticket**
1. En Plane: asignarse el ticket y pasarlo a **In Progress** (poner `start_date`).
2. Crear la rama, implementar, correr `flutter analyze` + `flutter test`.
3. Si hay cambios de esquema: `supabase migration new <nombre>`, escribir el SQL, probar con `supabase db reset`. Toda tabla nueva nace con `enable row level security`.
4. Abrir PR contra `develop` con resumen + test plan; enlazar el PR en un comentario del ticket.
5. Al mergear: ticket a **Done**. Quien mergea a `develop` corre `supabase db push` / `supabase config push` si el PR trae migraciones o cambios de `config.toml`.

**Reglas**
- Nada de secretos en el repo (`service_role`/`secret` key jamás en la app; la publishable/anon sí puede ir en el cliente).
- El esquema de la base se cambia solo por migraciones, nunca desde el dashboard.
- Imports con `package:catem_app/...`; regla de dependencia de Clean Architecture en [`catem_app/lib/README.md`](catem_app/lib/README.md).
- Estados en Plane: `Backlog` (bloqueado o sin priorizar) → `Todo` (listo para tomar) → `In Progress` → `Done`.

## Estado del Ciclo 1 – Fundación (2026-09-24 → 2026-10-08)

| Ticket | Estado | Notas |
|---|---|---|
| CATEM-14 Setup proyecto Flutter | Done | PR #1 |
| CATEM-19 Arquitectura de carpetas | Done | PR #1, feature `auth` como plantilla |
| CATEM-15 Setup proyecto Supabase | In Progress | Proyecto `ggnbkxnvofjpjyxrksjq` (us-east-2), migración y auth config aplicadas. Falta invitar al equipo desde el dashboard. |
| CATEM-16 Docker / entorno local | Done | `supabase start` + `db reset` documentados |
| CATEM-17 CI/CD | Todo | Sin bloqueos |
| CATEM-20 Cache local (drift) | Todo | Sin bloqueos |
| CATEM-80 Buckets de Storage | Todo | Sin bloqueos |
| CATEM-81 Suite de tests | Todo | Sin bloqueos |
| CATEM-18 FCM | Backlog | Necesita proyecto Firebase y cuenta Apple Developer |
| CATEM-21 a 25, 99 (auth/onboarding) | Backlog | Esperan los mockups de Figma (CATEM-74, 75) |
| CATEM-74, 75 Figma | Backlog | Design system y prototipo |

Decisiones tomadas hoy:
- Región de Supabase: se mantiene **us-east-2 (Ohio)**; la latencia desde Colombia es igual o mejor que São Paulo y no se puede cambiar sin recrear el proyecto.
- Se quitaron `custom_lint`/`riverpod_lint` del proyecto Flutter porque fijaban una versión vieja del analyzer.
- Los archivos generados (`*.g.dart`) se commitean para que el CI no dependa de `build_runner`.
- El `config.toml` de Supabase se sincroniza con `supabase config pull` antes de editar, para no pisar la configuración remota.
