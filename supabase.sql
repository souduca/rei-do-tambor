-- O Rei do Tambor — estrutura do banco de dados
-- Cole tudo isto no Supabase > SQL Editor > New query e clique em Run.

-- 1) Tabela única onde ficam estoque, pedidos, clientes, fornecedores, financeiro e saídas
create table if not exists public.registros (
  colecao       text        not null,
  id            text        not null,
  dados         jsonb       not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now(),
  primary key (colecao, id)
);

-- 2) Só quem entrou com a senha da empresa pode ver e mexer nos dados
alter table public.registros enable row level security;

drop policy if exists "empresa le"     on public.registros;
drop policy if exists "empresa grava"  on public.registros;
drop policy if exists "empresa altera" on public.registros;
drop policy if exists "empresa apaga"  on public.registros;
create policy "empresa le"     on public.registros for select to authenticated using (true);
create policy "empresa grava"  on public.registros for insert to authenticated with check (true);
create policy "empresa altera" on public.registros for update to authenticated using (true) with check (true);
create policy "empresa apaga"  on public.registros for delete to authenticated using (true);

-- 3) Atualização ao vivo entre celular e computador
alter table public.registros replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.registros;
exception when duplicate_object then null; end $$;

-- 4) Pasta das fotos dos tambores
insert into storage.buckets (id, name, public)
values ('fotos', 'fotos', true)
on conflict (id) do nothing;

drop policy if exists "fotos ler"    on storage.objects;
drop policy if exists "fotos enviar" on storage.objects;
drop policy if exists "fotos apagar" on storage.objects;
create policy "fotos ler"    on storage.objects for select using (bucket_id = 'fotos');
create policy "fotos enviar" on storage.objects for insert to authenticated with check (bucket_id = 'fotos');
create policy "fotos apagar" on storage.objects for delete to authenticated using (bucket_id = 'fotos');
