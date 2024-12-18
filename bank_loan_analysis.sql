select * from bank_loan_data;

select COUNT(id) AS Total_Applications from bank_loan_data;

--month to date total loan application
select COUNT(id) AS MTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 12 AND year(issue_date) = 2021;

--previous month to date total loan application
select COUNT(id) AS PMTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 11 AND year(issue_date) = 2021;

--total funded amount received from data
select SUM(total_payment) as Total_Amount_Received from bank_loan_data;

--month to date total payment of loan
select sum(total_payment) AS MTD_Total_Amount_Applications from bank_loan_data
where MONTH(issue_date) = 12 AND year(issue_date) = 2021;

--previous month
select sum(total_payment) AS PMTD_Total_Amount_Applications from bank_loan_data
where MONTH(issue_date) = 11 AND year(issue_date) = 2021;

--Average interest rate in percentage
select round(AVG(int_rate)*100, 2) as Avg_Interest_Rate from bank_loan_data;

--current month to average date
select round(AVG(int_rate)*100, 2) as MTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) =2021;

--previous month
select round(AVG(int_rate)*100, 2) as PMTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) =2021;

--dti should not very much high or not very much low

--Debt to income ratio

SELECT ROUND(avg(dti)*100, 2) as MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) =12 and year(issue_date) = 2021

--FOR PREVIOUS MONTH

SELECT ROUND(avg(dti)*100, 2) as PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 and year(issue_date) = 2021


--find loan status 

select loan_status from bank_loan_data

--good loan ={[count of (fully paid loan status and current loan status)]/ [count(id)]}*100

select
     (COUNT(case when loan_status ='Fully Paid' or loan_status = 'Current' then id end)*100)
	 /
	 COUNT(id) as Good_loan_percentage
from bank_loan_data;


--good loan application
select count(id) as Good_Loan_Applications from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';


--find the good loan funded amount meand the loan amount

select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';


--find god loan total received amount
select sum(total_payment) as Good_Loan_amount_received from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';


--BAD LOAN RECEIVED

--Bad loan percentage
select
     (COUNT(case when loan_status ='Charged Off' then id end)*100)
	 /
	 COUNT(id) as Bad_loan_percentage
from bank_loan_data;

--total applications of bad loan
select count(id) as Bad_Loan_Applications from bank_loan_data
where loan_status='charged Off'

--bad loan funded amount
select sum(total_payment) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status='charged Off';


--LOAN STATUS
SELECT 
      loan_status, 
	  count(id) as Total_Loan_Applications,
	  SUM(total_payment) as Total_Amount_Received,
	  SUM(loan_amount) as Total_Funded_Amount,
	  AVG(int_rate *100) as Interest_Rate,
	  AVG(dti * 100) as DTI
from
      bank_loan_data
group by
      loan_status;


-- month to date total amount received and month to date total amount funded
select 
      loan_status,
	  SUM(total_payment) as MTD_Total_Received,
	  SUM(loan_amount) as MTD_Total_Funded_Amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status;


--OVERVIEW 

--monthly trends by issue date
SELECT
     MONTH(issue_date) as Month_Number,
     DATENAME(MONTH, issue_date) as Month_Name,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by MONTH(issue_date), DATENAME(month, issue_date)
order by month(issue_date);


--regional analysis by state
SELECT
     address_state,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by address_state
order by address_state;


--regional analysis by state
SELECT
     address_state,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by address_state
order by sum(loan_amount) desc;


--LOAN TERM ANALYSIS - to allow the client to understand the distribution of loans across various term lengths
SELECT
     term,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by term
order by term;

 
SELECT
     emp_length,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by emp_length
order by count(id) desc;


SELECT
     home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by home_ownership
order by count(id) desc;


SELECT
     home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
where grade = 'A' 
group by home_ownership
order by count(id) desc;

    
SELECT
     home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
where grade = 'A' and address_state ='CA'
group by home_ownership
order by count(id) desc;


