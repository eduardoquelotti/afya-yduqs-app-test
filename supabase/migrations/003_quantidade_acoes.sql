-- Guarda a quantidade de ações (milhões) e a origem usadas em cada cálculo de market cap.
alter table public.historico
  add column if not exists yd_shares numeric,
  add column if not exists yd_shares_fonte text,
  add column if not exists af_shares numeric,
  add column if not exists af_shares_fonte text;
comment on column public.historico.yd_shares is 'Ações da Yduqs (milhões) usadas no market cap';
comment on column public.historico.af_shares is 'Ações da Afya (milhões) usadas no market cap';
update public.historico set yd_shares = yd_mc / yd_px, yd_shares_fonte = 'implícito (market cap brapi ÷ preço)'
  where yd_shares is null and yd_px > 0;
update public.historico set af_shares = af_usd / af_px, af_shares_fonte = 'Finnhub'
  where af_shares is null and af_px > 0;
