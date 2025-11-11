
select
    id_produto as id_produto_techloja,
    ean as ean_produto,
    nome_produto,
    case
        when preco is null or preco = '' then null
        
        else cast(
            regexp_replace(
                replace(preco, 'R$ ', ''), 
                '\.(?=.*\.)', 
                '',           
                'g'           
            )
        as numeric(10, 2))
    end as preco_em_reais,

    cast(em_estoque as boolean) as esta_em_estoque,
    cast(data_extracao as date) as data_extracao,
    'techloja' as fonte_dados
    
from {{ ref('raw_techloja') }}