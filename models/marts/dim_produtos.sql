{{
  config(
    materialized='table'
  )
}}

with
stg_techloja as (
    select distinct ean_produto, nome_produto
    from {{ ref('stg_techloja') }}
    where ean_produto is not null
),

stg_gadgetplace as (
    select distinct ean_produto, nome_produto
    from {{ ref('stg_gadgetplace') }}
    where ean_produto is not null
),

uniao_produtos as (
    select ean_produto, nome_produto from stg_techloja
    union
    select ean_produto, nome_produto from stg_gadgetplace
),

final as (
    select
        ean_produto,
        max(nome_produto) as nome_produto_mestre
    from uniao_produtos
    group by 1 
)

select
    {{ dbt_utils.generate_surrogate_key(['ean_produto']) }} as sk_produto,
    ean_produto,
    nome_produto_mestre
from final