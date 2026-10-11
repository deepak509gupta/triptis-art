-- Run this in Supabase Dashboard > SQL Editor.
create table if not exists public.artworks (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 100),
  category text not null,
  image text not null,
  description text not null default '',
  created_at timestamptz not null default now()
);
alter table public.artworks enable row level security;
drop policy if exists "Public can view artworks" on public.artworks;
create policy "Public can view artworks" on public.artworks for select to anon, authenticated using (true);
drop policy if exists "Signed-in owners can add artworks" on public.artworks;
create policy "Signed-in owners can add artworks" on public.artworks for insert to authenticated with check (true);
drop policy if exists "Signed-in owners can delete artworks" on public.artworks;
create policy "Signed-in owners can delete artworks" on public.artworks for delete to authenticated using (true);
-- Create a public Storage bucket named artworks in Storage > New bucket.
-- Storage policies for uploads/deletes: allow authenticated users only.
create policy "Authenticated upload artwork images" on storage.objects for insert to authenticated with check (bucket_id = 'artworks');
create policy "Public read artwork images" on storage.objects for select to anon, authenticated using (bucket_id = 'artworks');
create policy "Authenticated delete artwork images" on storage.objects for delete to authenticated using (bucket_id = 'artworks');
