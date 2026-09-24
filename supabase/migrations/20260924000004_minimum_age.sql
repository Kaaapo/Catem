-- CATEM-99 (RNF-13): Catem es 18+. La app valida en el registro; la base lo refuerza.

alter table public.profiles
  drop constraint if exists profiles_minimum_age_check;

alter table public.profiles
  add constraint profiles_minimum_age_check
  check (fecha_nacimiento is null or fecha_nacimiento <= (current_date - interval '18 years'));

comment on constraint profiles_minimum_age_check on public.profiles is
  'RNF-13: edad minima 18 anos calculada con fecha exacta, no solo el ano.';
