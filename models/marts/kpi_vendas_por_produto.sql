{{
  config(
    materialized='table'
  )
}}

with
vendas as (
    select * from {{ ref('stg_sales_events') }}
),

produtos as (
    select * from {{ ref('dim_produtos') }}
),

precos_historicos as (
    select * from {{ ref('fct_estoque_precos') }}
),

precos_recentes as (
    select
        ean_produto,
        fonte_dados as store_name,
        preco_em_reais,
        row_number() over(
            partition by ean_produto, fonte_dados
            order by data_extracao desc
        ) as rn
    from precos_historicos
),

precos_atuais as (
    select
        ean_produto,
        store_name,
        preco_em_reais
    from precos_recentes
    where rn = 1 
),

vendas_com_precos as (
    select
        v.data_hora_venda,
        v.quantity_sold,
        v.store_name,
        v.ean_produto,
        pa.preco_em_reais,
        (v.quantity_sold * pa.preco_em_reais) as receita_da_transacao
    from vendas as v
    left join precos_atuais as pa
        on v.ean_produto = pa.ean_produto
        and v.store_name = pa.store_name
),

final as (
    select
        p.sk_produto,
        p.ean_produto,
        p.nome_produto_mestre,
        
        sum(v.quantity_sold) as total_unidades_vendidas,
        sum(v.receita_da_transacao) as receita_total_bruta,
        
        count(distinct v.store_name) as total_lojas_venderam,
        count(*) as total_transacoes,
        min(v.data_hora_venda) as primeira_venda,
        max(v.data_hora_venda) as ultima_venda
        
    from vendas_com_precos as v
    left join produtos as p
        on v.ean_produto = p.ean_produto
    group by 1, 2, 3
)

select * from final