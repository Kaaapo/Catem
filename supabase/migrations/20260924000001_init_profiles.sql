-- CATEM-15: esquema inicial del Ciclo 1.
-- Las demas tablas del ERD se agregan en su ciclo correspondiente.

create extension if not exists postgis with schema extensions;

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  nick_publico text unique,
  nombre_real text,
  fecha_nacimiento date,
  ciudad text,
  consent_accepted_at timestamptz,
  terms_version text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table public.profiles is 'Perfil de usuario; 1:1 con auth.users.';
comment on column public.profiles.consent_accepted_at is 'RNF-01: fecha de aceptacion de terminos y politica de datos.';
comment on column public.profiles.terms_version is 'RNF-01: version del documento aceptado, para re-pedir consentimiento si cambia.';

create table if not exists public.profile_field_visibility (
  profile_id uuid not null references public.profiles (id) on delete cascade,
  field_name text not null,
  visibility text not null check (visibility in ('publico', 'amigos', 'privado')),
  primary key (profile_id, field_name)
);

comment on table public.profile_field_visibility is 'Visibilidad granular por campo del perfil (Ciclo 2).';

-- RLS activo desde el primer dia; las policies finas se afinan en el Ciclo 2.
alter table public.profiles enable row level security;
alter table public.profile_field_visibility enable row level security;

create policy "profiles: el dueno lee su perfil"
  on public.profiles for select to authenticated
  using ((select auth.uid()) = id);

create policy "profiles: el dueno actualiza su perfil"
  on public.profiles for update to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create policy "visibility: el dueno gestiona su visibilidad"
  on public.profile_field_visibility for all to authenticated
  using ((select auth.uid()) = profile_id)
  with check ((select auth.uid()) = profile_id);

-- updated_at automatico.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

-- CATEM-21 (punto 5): crear la fila de perfil al registrarse, via trigger y no desde el cliente.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id) values (new.id);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
