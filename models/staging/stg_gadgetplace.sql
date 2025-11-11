select
    sku as id_produto_gadgetplace,
    barcode as ean_produto,
    product_name as nome_produto,
    price as preco_em_reais,
    case
        when availability = 'In Stock' then true
        when availability = 'Out of Stock' then false
        else null
    end as esta_em_estoque,
    cast(timestamp as date) as data_extracao,
    'gadgetplace' as fonte_dados
from {{ ref('raw_gadgetplace') }}