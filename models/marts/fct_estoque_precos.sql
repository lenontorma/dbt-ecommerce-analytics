{{
  config(
    materialized='table'
  )
}}

with
stg_techloja as (
    select
        ean_produto,
        data_extracao,
        preco_em_reais,
        esta_em_estoque,
        fonte_dados
    from {{ ref('stg_techloja') }}
),

stg_gadgetplace as (
    select
        ean_produto,
        data_extracao,
        preco_em_reais,
        esta_em_estoque,
        fonte_dados
    from {{ ref('stg_gadgetplace') }}
),

uniao_fatos as (
    select * from stg_techloja
    union all
    select * from stg_gadgetplace
)

select
    {{ dbt_utils.generate_surrogate_key(['ean_produto']) }} as sk_produto,
    ean_produto,
    data_extracao,
    preco_em_reais,
    esta_em_estoque,
    fonte_dados
from uniao_fatos
where ean_produto is not null