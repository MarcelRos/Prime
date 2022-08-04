--P&L RO BY VERTICAL AND PRIME / NON PRIME

select order_country_code,
to_char(order_started_at,'YYYY-MM') as year_month,

-- FOOD & PRIME
count(case when order_is_food and order_is_prime then order_id end) as food_prime_orders,
sum(case when order_is_food and order_is_prime then order_gtv_eur end) as food_prime_gtv,
sum(case when order_is_food and order_is_prime then order_delivery_revenue_without_tax_eur end) as food_prime_delivery_revenue_without_tax_eur,
round(food_prime_delivery_revenue_without_tax_eur::numeric/nullif((food_prime_orders),0),6) as food_prime_avg_delivery_fee_wotax_eur,
sum(case when order_is_food and order_is_prime then order_total_partner_commission_eur end) as food_prime_partner_commission_eur,

-- FOOD & NON-PRIME
count(case when order_is_food and not order_is_prime then order_id end) as food_nonprime_orders,
sum(case when order_is_food and not order_is_prime then order_gtv_eur end) as food_nonprime_gtv,
sum(case when order_is_food and not order_is_prime then order_delivery_revenue_without_tax_eur end) as food_nonprime_delivery_revenue_without_tax_eur,
round(food_prime_delivery_revenue_without_tax_eur::numeric/nullif((food_prime_orders),0),6) as food_nonprime_avg_delivery_fee_wotax_eur,
sum(case when order_is_food and not order_is_prime then order_total_partner_commission_eur end) as food_nonprime_partner_commission_eur,

-- GROCERIES & PRIME
count(case when order_subvertical2 in ('MFC','Groceries') and order_is_prime then order_id end) as groceries_prime_orders,
sum(case when order_subvertical2 in ('MFC','Groceries') and order_is_prime then order_gtv_eur end) as groceries_prime_gtv,
sum(case when order_subvertical2 in ('MFC','Groceries') and order_is_prime then order_delivery_revenue_without_tax_eur end) as groceries_prime_delivery_revenue_without_tax_eur,
round(food_prime_delivery_revenue_without_tax_eur::numeric/nullif((food_prime_orders),0),6) as groceries_prime_avg_delivery_fee_wotax_eur,
sum(case when order_subvertical2 in ('MFC','Groceries') and order_is_prime then order_total_partner_commission_eur end) as food_prime_partner_commission_eur,

-- GROCERIES & NON-PRIME
count(case when order_subvertical2 in ('MFC','Groceries') and not order_is_prime then order_id end) as groceries_nonprime_orders,
sum(case when order_subvertical2 in ('MFC','Groceries') and not order_is_prime then order_gtv_eur end) as groceries_nonprime_gtv,
sum(case when order_subvertical2 in ('MFC','Groceries') and not order_is_prime then order_delivery_revenue_without_tax_eur end) as groceries_nonprime_delivery_revenue_without_tax_eur,
round(food_prime_delivery_revenue_without_tax_eur::numeric/nullif((food_prime_orders),0),6) as groceries_nonprime_avg_delivery_fee_wotax_eur,
sum(case when order_subvertical2 in ('MFC','Groceries') and not order_is_prime then order_total_partner_commission_eur end) as groceries_nonprime_partner_commission_eur

from bi_kpis.kpi_orders
where order_country_code='RO'
and order_final_status = 'DeliveredStatus'
and order_started_at >= '2022-05-01' and order_started_at < '2022-08-01' 

group by 1,2
order by 2;
