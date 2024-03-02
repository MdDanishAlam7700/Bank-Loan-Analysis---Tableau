CREATE DATABASE BankLoan_db
USE BankLoan_db

SELECT * FROM loan_data

-- Key Performance Indicators (KPIs) Requirements:

-- 1.Total Loan Applications
SELECT COUNT(id) AS Total_Application FROM loan_data
--MTD Applications
SELECT COUNT(id) AS MTD_Total_Application FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--PMTD
SELECT COUNT(id) AS PMTD_Total_Application FROM loan_data
WHERE MONTH(issue_date) = 11
-- MOM == ( MTD - PMTD) / {PMTD}



-- 2.Total Funded Amount
SELECT SUM(loan_amount) AS Total_Fundend_Amount FROM loan_data
--MTD
SELECT SUM(loan_amount) AS MTD_Total_Fundend_Amount FROM loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
--PMTD
SELECT SUM(loan_amount) AS PMTD_Total_Fundend_Amount FROM loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021



-- 3.Total Amount Received
SELECT SUM(total_payment) AS Total_Amt_Received FROM loan_data
--MTD
SELECT SUM(total_payment) AS MTD_Total_Amt_Received FROM loan_data
WHERE MONTH(issue_date) = 12
--PMTD
SELECT SUM(total_payment) AS PMTD_Total_Amt_Received FROM loan_data
WHERE MONTH(issue_date) = 11


--4.Average Interest Rate: 
SELECT ROUND(AVG(int_rate), 4) * 100 AS Avg_Int_Rate FROM loan_data
--MTD
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Int_Rate FROM loan_data
WHERE MONTH(issue_date) = 12
--PMTD
SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_Avg_Int_Rate FROM loan_data
WHERE MONTH(issue_date) = 11



--5.Average Debt-to-Income Ratio (DTI): 
SELECT ROUND(AVG(dti),4) *100  AS Avg_DTI FROM loan_data
--MTD
SELECT ROUND(AVG(dti),4) *100  AS MTD_Avg_DTI FROM loan_data
WHERE MONTH(issue_date) = 12
--PMTD
SELECT ROUND(AVG(dti),4)*100  AS PMTD_Avg_DTI FROM loan_data
WHERE MONTH(issue_date) = 11







-- Good Loan KPIs:
--1.Good Loan Application Percentage
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status='Current' THEN id END) * 100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM loan_data

--2. Good Loan Applications: 
SELECT COUNT(id) AS Good_Loan_Applications FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


--3. Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


--4. Good Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Total_Received FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- Bad Loan KPIs
--1. Bad Loan Application Percentage:
SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
	/
	COUNT(id) AS Bad_loan_percentage
FROM loan_data

--2. Bad Loan Applications: 
SELECT COUNT(id) AS Good_Loan_Applications FROM loan_data
WHERE loan_status = 'Charged Off'


--3. Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Applications FROM loan_data
WHERE loan_status = 'Charged Off'

--4. Bad Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Applications FROM loan_data
WHERE loan_status = 'Charged Off'

--5. Loan Status Grid View
SELECT 
	loan_status,
	COUNT(id) AS LoanCount,
	SUM(total_payment) AS Total_Amont_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate *100) AS Intrest_Rate,
	AVG(dti * 100) AS DTI
FROM loan_data
GROUP BY loan_status

--MTD
SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amont_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status


--------------------------------------------------------------------
----------------------Dashboard 2 -------------------------------
-- Monthly Trends by Issue Date
SELECT	
		MONTH(issue_date) AS Month_Number,
		DATENAME(MONTH,issue_date) AS Month_name,
		Count(id) AS Total_Loan_Applications,
		SUM(loan_amount) AS Total_Funded_Amount,
		SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY DATENAME(MONTH,issue_date) , MONTH(issue_date)
ORDER BY MONTH(issue_date)

-- Regional Analysis by State 
SELECT 
	address_state AS State,
	Count(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY address_state
ORDER BY address_state

-- . Loan Term Analysis
SELECT 
	term AS Loan_Term,
	Count(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY term
ORDER BY term

--. Employee Length Analysis 
SELECT 
	emp_length AS Emp_Length,
	Count(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY emp_length
ORDER BY emp_length

-- Loan Purpose Breakdown
SELECT 
	purpose AS Loan_Purpose,
	Count(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY purpose
ORDER BY purpose


-- Home Ownership
SELECT 
	home_ownership AS Home_Ownership,
	Count(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM loan_data
GROUP BY home_ownership
ORDER BY home_ownership



