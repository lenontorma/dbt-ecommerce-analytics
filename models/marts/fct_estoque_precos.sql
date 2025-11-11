{{
  config(
    materialized='incremental',
    unique_key=['ean_produto', 'data_extracao', 'fonte_dados']
  )
}}

with
stg_techloja as (
    select * from {{ ref('stg_techloja') }}
),

stg_gadgetplace as (
    select * from {{ ref('stg_gadgetplace') }}
),

uniao_fatos as (
    select
        ean_produto,
        data_extracao,
        preco_em_reais,
        esta_em_estoque,
        fonte_dados
    from stg_techloja

    union all

    select
        ean_produto,
        data_extracao,
        preco_em_reais,
        esta_em_estoque,
        fonte_dados
    from stg_gadgetplace
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


{% if is_incremental() %}
  and data_extracao > (select max(data_extracao) from {{ this }})

{% endif %}