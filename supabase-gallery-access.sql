-- QR Photo Quality gallery read access
-- Run this in Supabase SQL Editor after supabase-setup.sql.
-- This allows the public gallery page to list submitted metadata and generate signed image links.

alter table public.photo_submissions enable row level security;

grant select on public.photo_submissions to anon;

drop policy if exists "Allow public field photo metadata reads" on public.photo_submissions;
create policy "Allow public field photo metadata reads"
  on public.photo_submissions
  for select
  to anon
  using (true);

drop policy if exists "Allow public field photo object reads" on storage.objects;
create policy "Allow public field photo object reads"
  on storage.objects
  for select
  to anon
  using (bucket_id = 'field-photos');