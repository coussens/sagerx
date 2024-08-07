-- stg_ashp__current_drug_shortages.sql

with 

ashp_shortage_list as (

    select * from {{ source('ashp', 'ashp_shortage_list') }}

),

current_drug_shortages as (

    select
        split_part(detail_url, '=', 2) as id,
        name,
        concat(
            'https://www.ashp.org/drug-shortages/current-shortages/',
            lower(detail_url)) as url,
        created_date,
        update_date
    from ashp_shortage_list

)

select
    *
from current_drug_shortages
