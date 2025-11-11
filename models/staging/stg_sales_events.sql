-- models/staging/stg_sales_events.sql
select
    order_id,
    product_ean as ean_produto,
    quantity_sold,
    lower(store_name) as store_name,
    cast(sale_timestamp as timestamp) as data_hora_venda,
    cast(sale_timestamp as date) as data_venda 
from {{ ref('raw_sales_events') }}