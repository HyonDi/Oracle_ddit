-- cart_member, cart_prod
-- ==> 회원별 카트 수량합, 제품별 카트 수량합

SELECT cart_member, cart_prod, SUM(cart_qty) sum_cart_qty
FROM cart
GROUP BY GROUPING SETS (cart_member, cart_prod);