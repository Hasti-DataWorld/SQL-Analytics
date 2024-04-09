
/* 
I Picked one city and grouped the businesses in that city by their overall star rating.
I chose 'Las Vegas' and the 'Shopping' category to compare businesses.
I Compared the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. 
I developed my code by adding the opening hours, and average of the opening time and closing time of 
bussiness in each star rating sub-category and then I added the review counts for comparison

1. Do the two groups you chose to analyze have a different distribution of hours?

the answer is YES. 

I used the city 'Las Vegas' and the 'Shopping' category to compare businesse.
In 'Las Vegas', businesses in 'shopping' category with 2-3 star rating are open after 5 pm
while businesses in 'shopping' category with 4-5 star rating are not open after 5 pm.
Also I calculated the average opening and closing time for 2-3 star rating shopping businesses in Las Vegas and 
compared it with 4-5 star rating to find the difference in the  distribution of hours 
we can see the difference below:


2. Do the two chosen groups have a different number of reviews?

the answer is YES. 
         
4-5 star rating businesses in Las Vegas and in 'shopping' category have higher number of reviews (244 reviews)
compared to 2-3 star rating businesses (108) as we see below:
+-------------------+-----------------+
| star_rating_group | total_N_reviews |
+-------------------+-----------------+
| 2-3 Stars         |  108            |
| 4-5 Stars         |  244            |
+-------------------+-----------------+

    
3. Are we able to infer anything from the location data provided between these two groups? 

Based on the location data provided, we can infer that businesses with 2-3 stars and businesses with 4-5 stars 
are located in different areas within Las Vegas. Specifically:

Businesses with 2-3 stars are located at addresses such as 3421 E Tropicana Ave and 3808 E Tropicana Ave.
Businesses with 4-5 stars are located at addresses such as 1000 Scenic Loop Dr and 3555 W Reno Ave.
Additionally, it could indicate potential differences in the types of businesses or demographics of 
customers in these areas, which may influence the ratings they receive.

SQL code used for analysis:
*/


SELECT 
    CASE 
        WHEN b.stars >= 4 THEN '4-5 Stars'
        WHEN b.stars >= 2 AND b.stars < 4 THEN '2-3 Stars'
        ELSE '1 Star or Less'
    END AS star_rating_group,

    -- comparing average opening and closing time

    SUBSTR(h.HOURS, INSTR(h.HOURS, '|') + 1) AS OPENING_HOURS,
    AVG(SUBSTR(SUBSTR(h.HOURS, INSTR(h.HOURS, '|') + 1), 1, 2) * 1.0) AS avg_opening_time,
    AVG(SUBSTR(SUBSTR(h.HOURS, INSTR(h.HOURS, '-') + 1), 1, 2) * 1.0) AS avg_closing_time,

    -- comparing number of reviews

    SUM(b.review_count) as total_N_reviews

    -- joining tables
FROM 
    business b
INNER JOIN 
    hours h ON b.id = h.business_id
INNER JOIN 
    category c ON b.id = c.business_id

WHERE 
    b.city = 'Las Vegas' 
    AND c.category = 'Shopping'
GROUP BY 
    star_rating_group; 






/* to address the location question (number 3), I added the location columns into my code
and did group by by location information as follow */


SELECT 
    CASE 
        WHEN b.stars >= 4 THEN '4-5 Stars'
        WHEN b.stars >= 2 AND b.stars < 4 THEN '2-3 Stars'
        ELSE '1 Star or Less'
    END AS star_rating_group,
    b.address,
    b.city,
    b.state,
    b.postal_code,
    b. latitude,
    b.longitude,

    COUNT(*) AS business_count
FROM 
    business b
JOIN 
    category c ON b.id = c.business_id
WHERE 
    b.city = 'Las Vegas' 
    AND c.category = 'Shopping'
GROUP BY 
    star_rating_group, b.address, b.city, b.state, b.postal_code, b. latitude, b.longitude ;



		
/* Grouping business based on the ones that are open and the ones that are closed. 
finding the differences between the ones that are still open and the ones that are closed? 
		
i. Difference 1:  bussiness counts and Average Review Count
Open businesses have a higher count compared to closed businesses.
Open businesses have a higher average review count compared to closed businesses.  

ii. Difference 2: Average Star Rating
Open businesses tend to have a slightly higher average star-rating compared to closed businesses.
         
I used case statement to find open and closed businesses,
SQL code used for analysis:

 */

SELECT
    CASE
        WHEN b.is_open = 1 THEN 'Open'
        ELSE 'Closed'
    END AS business_status,
    COUNT(*) AS business_count,
    SUM(b.review_count) AS SUM_review_count,
    AVG(b.stars) AS avg_star_rating
FROM
    business b
GROUP BY
    business_status;




/* 

In this part of the project I want to help the businesses to predict their overall star-rating. 
so they need to work toward improvment or make vital desicions.     
To conduct this project and research, I gather all the data needed to help the business, 
These include the number of reviews, the business's star rating, operational hours, and notably, 
its geographical location. Gathering latitude and longitude coordinates alongside details such as 
city, state, postal code, and address will facilitate streamlined data processing in subsequent analyses. 
Additionally, leveraging categories and attributes will aid in distinguishing between various business types. 
Furthermore, the attribute is_open will delineate between active businesses and those that have permanently closed.

         
the SQL code to create your final dataset:
*/

SELECT B.id,
			   B.name,
			   B.address,
			   B.city,
			   B.state,
			   B.postal_code,
			   B.latitude,
			   B.longitude,
			   B.review_count,
			   B.stars,
			   MAX(CASE
			   WHEN H.hours LIKE "%monday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS monday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%tuesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS tuesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%wednesday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS wednesday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%thursday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS thursday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%friday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS friday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%saturday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS saturday_hours,
			   MAX(CASE
			   WHEN H.hours LIKE "%sunday%" THEN TRIM(H.hours,'%MondayTuesWednesThursFriSatSun|%') 
			   END) AS sunday_hours,
			   GROUP_CONCAT(DISTINCT(C.category)) AS categories,
			   GROUP_CONCAT(DISTINCT(A.name)) AS attributes,
			   B.is_open
		FROM business B
		INNER JOIN hours H
		ON B.id = H.business_id
		INNER JOIN category C
		ON B.id = C.business_id
		GROUP BY B.id;                         
                  
