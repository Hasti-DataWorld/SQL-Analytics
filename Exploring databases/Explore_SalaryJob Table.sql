/* In these SQL code snippets I have used the Salary by Job Range Table. 
This is a single table titled: salary_range_by_job_classification. 
This table contains the following columns:

SetID

Job_Code 

Eff_Date 

Sal_End_Date 

Salary_setID 

Sal_Plan 

Grade 

Step 

Biweekly_High_Rate 

Biweekly_Low_Rate 

Union_Code 

Extended_Step 

Pay_Type */



-- Finding the distinct values for the extended step

SELECT 
    job_code,
    Extended_Step,
    Pay_Type
FROM salary_range_by_job_classification
    WHERE Pay_Type = 'M' OR Pay_Type='H' OR Pay_Type='D';


-- dig into table
SELECT 
    Union_Code,
    Step,
    SetID
FROM salary_range_by_job_classification
    WHERE Union_Code = '990' AND (SetID = 'SFMTA' OR SetID='COMMN') ;




-- Excluding $0.00 to find the minimum bi-weekly high rate of pay 

Select 
    min(Biweekly_high_Rate) AS my_min
FROM salary_range_by_job_classification
    WHERE Biweekly_high_Rate <> '$0.00';


-- dig into pay

SELECT 
    job_code,
    Biweekly_low_Rate,
    Biweekly_high_Rate,
    (Biweekly_high_Rate - Biweekly_low_Rate) AS subt
FROM salary_range_by_job_classification
    WHERE job_code = '0170';



-- finding the pay type for all the job codes that start with '03'
SELECT 
    job_code,
    pay_type
FROM salary_range_by_job_classification
    WHERE job_code LIKE '03%';


-- finding the Effective Date (eff_date) or Salary End Date for grade Q90H0

SELECT 
    grade,
    eff_date,
    sal_end_date
FROM salary_range_by_job_classification
    WHERE grade = 'Q90H0';



