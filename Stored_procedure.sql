-- #7 Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
-- For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
   
   delimiter &&
    CREATE procedure procedure1()
    BEGIN
    select report.supp_id, report.supp_name, report.average,
    CASE
	WHEN report.Average =5 THEN 'Excellent Service'
        WHEN report.Average >4 THEN 'Good Service'
	WHEN report.Average >2 THEN 'Average Service'
        ELSE 'Poor Service'
    END As Type_of_Service from
        (select final.supp_id, supplier.supp_name, final.Average from
        (select test2.supp_id, sum(test2.rat_ratstars) as Average from 
        (select supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing inner join
        (select `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from `order`inner join rating on rating.ord_id = `order`.ord_id) as test )
        as test2 group by supplier_pricing.supp_id) as final inner join supplier
        where final.supp_id = supplier.supp_id) as report;
    END &&
    
    call procedure1();
