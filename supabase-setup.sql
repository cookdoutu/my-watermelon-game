-- Supabase SQL Editorで実行してください。
-- 先にAuth > Usersで管理者ユーザーを作成し、下のメールアドレスを同じものに変更してください。
-- 例: admin@example.com
create table if not exists public.game_config (
  id integer primary key check (id = 1),
  title text not null default 'マイ・スイカゲーム',
  images jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.game_config enable row level security;

drop policy if exists "Public can read game config" on public.game_config;
create policy "Public can read game config"
on public.game_config for select to anon, authenticated using (true);

drop policy if exists "Only owner can update game config" on public.game_config;
create policy "Only owner can update game config"
on public.game_config for update to authenticated
using ((auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL')
with check ((auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL');

drop policy if exists "Only owner can insert game config" on public.game_config;
create policy "Only owner can insert game config"
on public.game_config for insert to authenticated
with check ((auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL');

insert into public.game_config (id, title, images)
values (1, 'マイ・スイカゲーム', '[]'::jsonb)
on conflict (id) do nothing;

insert into storage.buckets (id, name, public)
values ('game-images', 'game-images', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can view game images" on storage.objects;
create policy "Public can view game images"
on storage.objects for select to anon, authenticated
using (bucket_id = 'game-images');

drop policy if exists "Only owner can upload game images" on storage.objects;
create policy "Only owner can upload game images"
on storage.objects for insert to authenticated
with check (
  bucket_id = 'game-images'
  and (auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL'
);

drop policy if exists "Only owner can update game images" on storage.objects;
create policy "Only owner can update game images"
on storage.objects for update to authenticated
using (
  bucket_id = 'game-images'
  and (auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL'
)
with check (
  bucket_id = 'game-images'
  and (auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL'
);

drop policy if exists "Only owner can delete game images" on storage.objects;
create policy "Only owner can delete game images"
on storage.objects for delete to authenticated
using (
  bucket_id = 'game-images'
  and (auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL'
);
