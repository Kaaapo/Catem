# Backend local de Catem (Supabase)

Todo el esquema de la base de datos vive versionado aquí (`migrations/`), junto al código Flutter. El dashboard de producción **no** es la fuente de verdad: cualquier cambio de esquema se hace como migración y se aplica con la CLI.

## Requisitos

- Docker Desktop corriendo (en Apple Silicon, desactivar "Use Rosetta for x86_64/amd64 emulation" en Settings > General si Docker no arranca).
- Supabase CLI: `brew install supabase/tap/supabase` (macOS) o `npm install -g supabase`.

## Primera vez (< 10 min)

```bash
git clone https://github.com/Kaaapo/Catem.git && cd Catem
supabase start          # levanta Postgres, Auth, Storage, Realtime y Studio en Docker
supabase db reset       # aplica todas las migraciones desde cero
supabase status         # muestra URLs y keys locales
```

Con `supabase status` copia `API URL` y la `publishable`/`anon key` local a `catem_app/env/dev.json` (partiendo de `env/dev.json.example`) y corre la app:

```bash
cd catem_app
flutter run --dart-define-from-file=env/dev.json
```

En emulador Android usa `http://10.0.2.2:54321` en vez de `127.0.0.1`.

## Puertos locales

| Servicio | URL |
|---|---|
| API (REST/Auth/Storage) | http://127.0.0.1:54321 |
| Postgres | `postgresql://postgres:postgres@127.0.0.1:54322/postgres` |
| Studio (dashboard local) | http://127.0.0.1:54323 |
| Mailpit (correos de auth: confirmación, reset) | http://127.0.0.1:54324 |

## Día a día

```bash
supabase start / supabase stop        # levantar / apagar el stack
supabase migration new <nombre>       # crea migrations/<timestamp>_<nombre>.sql (escribir el SQL ahí)
supabase db reset                     # recrea la DB local aplicando todas las migraciones
supabase migration list               # compara migraciones locales vs remotas
supabase db push                      # aplica migraciones pendientes al proyecto cloud (solo desde develop/main)
supabase config push                  # sube cambios de config.toml (auth, storage...) al proyecto cloud
```

Reglas:
- Nunca editar el esquema desde el dashboard cloud; siempre migración + PR.
- Toda tabla nueva nace con `enable row level security` en la misma migración.
- `db push` y `config push` los ejecuta quien mergea a `develop`, después de probar con `db reset` en local.

## Migraciones actuales

| Archivo | Ticket | Contenido |
|---|---|---|
| `20260924000001_init_profiles.sql` | CATEM-15/21/25 | PostGIS, `profiles` (con consentimiento), `profile_field_visibility`, RLS, trigger `updated_at`, trigger que crea el perfil al registrarse |
| `20260924000002_device_tokens.sql` | CATEM-18 | `device_tokens` (FCM) con RLS |
| `20260924000003_storage_buckets.sql` | CATEM-80 | buckets `avatars` y `recommendations_media` privados + 8 policies por carpeta `{user_id}/` |
| `20260924000004_minimum_age.sql` | CATEM-99 | check `profiles_minimum_age_check` (18+) |

## Config de auth (`config.toml`)

- `site_url` y `additional_redirect_urls` apuntan a los deep links `catem://auth-callback/...`.
- Confirmación de email activa; OTP de 8 dígitos por email (valor del proyecto cloud).
- Proveedores Google/Apple y Twilio (SMS) están **desactivados** hasta tener credenciales. Los secretos van por variables de entorno (`SUPABASE_AUTH_EXTERNAL_GOOGLE_SECRET`, etc.), nunca en el archivo.
- Antes de editar: `supabase config pull` para partir del estado remoto; después: `supabase config diff` y `supabase config push`.

## Proyecto cloud

- Ref: `ggnbkxnvofjpjyxrksjq` (org Katchdev, región us-east-2). `supabase link --project-ref ggnbkxnvofjpjyxrksjq` tras `supabase login`.
- Las keys (`publishable`/`anon` para la app, `secret`/`service_role` solo para Edge Functions) se toman del dashboard; **nunca** se commitean.
