-- CATEM-18: tokens FCM por dispositivo para despachar push desde Edge Functions (RNF-04).

create table if not exists public.device_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  token text not null unique,
  platform text not null check (platform in ('android', 'ios')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists device_tokens_user_id_idx on public.device_tokens (user_id);

comment on table public.device_tokens is 'Token FCM por dispositivo; un usuario puede tener varios.';

alter table public.device_tokens enable row level security;

create policy "device_tokens: el dueno gestiona sus tokens"
  on public.device_tokens for all to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create trigger device_tokens_set_updated_at
  before update on public.device_tokens
  for each row execute function public.set_updated_at();
