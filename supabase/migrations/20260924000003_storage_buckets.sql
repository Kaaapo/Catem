-- CATEM-80: buckets de Storage para avatares y multimedia de recomendaciones, con RLS por carpeta de usuario.
-- Convencion de rutas: {bucket}/{user_id}/... -> (storage.foldername(name))[1] = user_id.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  ('avatars', 'avatars', false, 5242880, array['image/jpeg', 'image/png', 'image/webp']),
  ('recommendations_media', 'recommendations_media', false, 10485760, array['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'video/mp4'])
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

-- avatars
drop policy if exists "Avatares visibles por usuarios autenticados" on storage.objects;
create policy "Avatares visibles por usuarios autenticados"
  on storage.objects for select to authenticated
  using (bucket_id = 'avatars');

drop policy if exists "Usuario solo sube su propio avatar" on storage.objects;
create policy "Usuario solo sube su propio avatar"
  on storage.objects for insert to authenticated
  with check (bucket_id = 'avatars' and (select auth.uid())::text = (storage.foldername(name))[1]);

drop policy if exists "Usuario solo actualiza su propio avatar" on storage.objects;
create policy "Usuario solo actualiza su propio avatar"
  on storage.objects for update to authenticated
  using (bucket_id = 'avatars' and (select auth.uid())::text = (storage.foldername(name))[1]);

drop policy if exists "Usuario solo borra su propio avatar" on storage.objects;
create policy "Usuario solo borra su propio avatar"
  on storage.objects for delete to authenticated
  using (bucket_id = 'avatars' and (select auth.uid())::text = (storage.foldername(name))[1]);

-- recommendations_media
drop policy if exists "Media de recomendaciones visible por autenticados" on storage.objects;
create policy "Media de recomendaciones visible por autenticados"
  on storage.objects for select to authenticated
  using (bucket_id = 'recommendations_media');

drop policy if exists "Usuario solo sube su propia media" on storage.objects;
create policy "Usuario solo sube su propia media"
  on storage.objects for insert to authenticated
  with check (bucket_id = 'recommendations_media' and (select auth.uid())::text = (storage.foldername(name))[1]);

drop policy if exists "Usuario solo actualiza su propia media" on storage.objects;
create policy "Usuario solo actualiza su propia media"
  on storage.objects for update to authenticated
  using (bucket_id = 'recommendations_media' and (select auth.uid())::text = (storage.foldername(name))[1]);

drop policy if exists "Usuario solo borra su propia media" on storage.objects;
create policy "Usuario solo borra su propia media"
  on storage.objects for delete to authenticated
  using (bucket_id = 'recommendations_media' and (select auth.uid())::text = (storage.foldername(name))[1]);
