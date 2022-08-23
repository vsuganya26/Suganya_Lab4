--  #1: Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.

select count(t2.cus_gender) as NoOfCustomers, t2. cus_gender from
(select t1.cus_id, t1.cus_gender, t1.ord_amount, t1.cus_name from
(select `order`.*, customer.cus_gender, customer.cus_name from `order` inner join customer 
where `order`.cus_id = customer.cus_id having `order`.ord_amount >= 3000)
as t1 group by t1.cus_id) as t2 group by t2.cus_gender;
    
-- #2: Display all the orders along with product name ordered by a customer having Customer_Id=2

select product.PRO_ID,product.PRO_NAME, `order`.* from `ORDER`, product, supplier_pricing
where `ORDER`.CUS_ID = 2 and `ORDER`.PRICING_ID = supplier_pricing.PRICING_ID and supplier_pricing.PRO_ID = product.PRO_ID;

-- #3: Display the Supplier details who can supply more than one product.

select supplier.* from supplier where supplier.supp_id in 
(select supp_id from supplier_pricing group by supp_id 
having count(supp_id) >1) group by supplier.supp_id; 
 
-- #4: Find the least expensive product from each category and print the table with category id, name, product name and price of the product

select category.cat_id, category.cat_name, min(t3.min_price) as Min_price from Category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join
(select pro_id, min(supp_price) as Min_price from supplier_pricing group by pro_id)
as t2 where t2.pro_id = product.pro_id)
as t3 where t3.cat_id = category.cat_id group by t3.cat_id;
 
-- #5: Display the Id and Name of the Product ordered after “2021-10-05”.
 
select product.pro_id, product.pro_name, product.pro_desc from `order`
inner join supplier_pricing on `order`.pricing_id = supplier_pricing.pricing_id
inner join product on supplier_pricing.pro_id = product.pro_id
where `order`.ord_date > "2021-10-05";
 
-- #6: Display customer name and gender whose names start or end with character 'A'.

select cus_name, cus_gender from `customer` where cus_name like 'A%' or cus_name like '%A';
