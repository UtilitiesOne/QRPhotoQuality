-- QR Photo Quality Supabase setup
-- Run this in Supabase SQL Editor for project zrvoejuicneeowfijxvf.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'field-photos',
  'field-photos',
  false,
  15728640,
  array['image/jpeg', 'image/png', 'image/webp', 'image/heic', 'image/heif']
)
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

create table if not exists public.photo_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  division text not null,
  location text not null,
  photo_type text not null,
  storage_bucket text not null default 'field-photos',
  storage_path text not null,
  file_name text not null,
  mime_type text,
  size_bytes bigint,
  quality_status text not null,
  quality_issues jsonb not null default '[]'::jsonb,
  megapixels numeric,
  brightness_score integer,
  sharpness_score integer
);

alter table public.photo_submissions enable row level security;

grant usage on schema public to anon;
grant insert on public.photo_submissions to anon;

drop policy if exists "Allow public field photo metadata inserts" on public.photo_submissions;
create policy "Allow public field photo metadata inserts"
  on public.photo_submissions
  for insert
  to anon
  with check (true);

drop policy if exists "Allow public field photo uploads" on storage.objects;
create policy "Allow public field photo uploads"
  on storage.objects
  for insert
  to anon
  with check (bucket_id = 'field-photos');