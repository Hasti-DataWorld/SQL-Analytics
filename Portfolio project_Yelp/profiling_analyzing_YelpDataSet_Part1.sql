/*Data Scientist role play Project:

Profiling and Analyzing the Yelp Dataset
TO
Address Bussines Questions */




-- Profile the data by finding the total number of records for each of the tables below
SELECT COUNT(*) AS total_records_Attribute
FROM Attribute;
 

SELECT COUNT(*) AS total_records
FROM Business;

SELECT COUNT(*) AS total_records
FROM Category;




/* Query to find the total records using Primary or Foreign key in each following table. 
Can find the key in ER diagram using one-many relationships 

If two foreign keys are listed in the table, I specified that foreign key:
Table Tip has TWO FOREIGN KEYS */

SELECT COUNT(DISTINCT id) AS total_distinct_records
FROM Business;


SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Hours;

SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Attribute;


SELECT COUNT(DISTINCT user_id) AS total_distinct_records
FROM Tip;


SELECT COUNT(DISTINCT business_id) AS total_distinct_records
FROM Tip;





-- Archecking whether any columns with null values in the Users table? 
-- checking all the columns in User table to find any Null rows in any of the columns 
	
SELECT *
FROM User
WHERE id IS NULL OR name IS NULL OR review_count IS NULL OR yelping_since IS NULL 
OR useful IS NULL OR funny IS NULL OR cool IS NULL OR fans IS NULL  
OR average_stars IS NULL OR compliment_hot IS NULL OR compliment_more IS NULL 
OR compliment_profile IS NULL OR compliment_cute IS NULL OR compliment_list IS NULL 
OR compliment_note IS NULL OR compliment_plain IS NULL OR compliment_cool IS NULL
OR compliment_funny IS NULL OR compliment_writer IS NULL OR compliment_photos IS NULL;



	
-- For each table and column listed below, finding the smallest, largest , and average value:
-- EXAMPLE SQL CODE using aggregate functions:

SELECT

    MIN(stars) AS minimum,
    MAX(stars) AS maximum,
    AVG(stars) AS avgerage

FROM
    Review;





-- Listing the cities with the most reviews in descending order:
-- In this query, I group by the table by 'City' and Sum the number of reviews for each city

SELECT CITY,
SUM (REVIEW_count) AS tot_review
FROM BUSINESS

GROUP BY CITY
ORDER BY tot_review DESC;


	
	
-- Finding the distribution of star ratings to the business in the following cities:
SELECT stars AS star_rating, COUNT(*) AS count

FROM 
	Business

WHERE city = 'Avon'
GROUP BY star_rating;


SELECT stars AS star_rating, COUNT(*) AS count

FROM 
	Business

WHERE city = 'Beachwood'
GROUP BY star_rating;





-- Finding the top 3 users based on their total number of reviews:
SELECT id, NAME,  REVIEW_COUNT

FROM 
	user

	ORDER BY REVIEW_COUNT DESC
	LIMIT 3; 
	
		

		


/* !!!!ANSWERING BUSSINES QUESTION: 
	Does posing more reviews correlate with more fans???

	
 To answer this question
 I used a SQL query to group the User table based on the review_count 
 and then I summed the number of fans for each group

RESULTS:
Based on the first 25 rows returned, we can observe that there is no one-to-one correlation 
between the total review counts and the number of fans. 
For instance, the maximum review_count is 2000 with a total fans number of 253,
whereas a smaller review_count of 968 exhibits a higher summed fan count of 497. 
The findings suggest that there isn't a direct correlation between the total 
number of reviews posted by users and the number of fans they have. 
In other words, having a higher review count doesn't necessarily mean having more fans. 
My interpretation is that factors other than review activity could influence the number 
of fans a user has, such as the quality or popularity of their reviews.

 */

SELECT id, name, review_count, SUM(fans) AS sum_fans

FROM 
	User

	GROUP BY review_count
	ORDER BY review_count DESC;





	
/*Are there more reviews with the word "love" or with the word "hate" in them?
I used subquery to write this SQL code and find the answer 

+------------+------------+
| love_count | hate_count |
+------------+------------+
|       1780 |        232 |
+------------+------------+

SQL code used to arrive at answer:

*/

SELECT 
    (SELECT COUNT(*) FROM review WHERE text LIKE '%love%') AS love_count,
    (SELECT COUNT(*) FROM review WHERE text LIKE '%hate%') AS hate_count;
	




-- Finding the top 10 users with the most fans:	
SELECT id, name, fans

FROM User

ORDER BY fans DESC
LIMIT 10;


