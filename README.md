# bank_loan_analysis1

## Overview
This project aims to analyze a bank's loan dataset to identify patterns and factors that distinguish good loans from bad loans. By leveraging Python libraries such as pandas, numpy, matplotlib, and seaborn, the analysis focuses on deriving actionable insights to optimize risk assessment, improve loan approval processes, and enhance overall financial decision-making

## Objective
**Objective of Bank Loan Analysis Project**:  

The objective of the Bank Loan Analysis project is to analyze loan data to identify patterns and trends in good and bad loans, enabling the bank to make data-driven decisions to minimize risks and improve profitability. By examining factors such as loan amounts, interest rates, borrower profiles, creditworthiness, and repayment patterns, the project aims to:  
1. Classify loans into "good" and "bad" categories based on repayment behavior.  
2. Identify key factors influencing loan defaults.  
3. Provide actionable insights to optimize the loan approval process.  
4. Enhance risk assessment models to improve the bank’s lending strategy.  
5. Visualize data trends for effective communication with stakeholders.  

This analysis will help the bank in mitigating risks, improving customer segmentation, and maximizing financial returns while maintaining a healthy loan portfolio.

## Dataset Used
- <a href="https://github.com/SnehalDeepa/bank_loan_analysis1/blob/main/financial_loan_data.csv">Dataset</a>

## Tools Used
- SQL Server - Data Analysis
- Tableau - Creating report
- Excel - Data cleaning, creating report

## Project SQL Schema

**Data Overlook**:
```sql
select * from bank_loan_data;
```
**Counting rows**:
By using COUNT function
```sql
select COUNT(id) AS Total_Applications from bank_loan_data;
```

**month to date total loan application**:
```sql
select COUNT(id) AS MTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 12 AND year(issue_date) = 2021;
```

**previous month to date total loan application**:
```sql
select COUNT(id) AS PMTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 11 AND year(issue_date) = 2021;
```

**total funded amount received from data**:
```sql
select SUM(total_payment) as Total_Amount_Received from bank_loan_data;
```

**month to date total payment of loan**:
```sql
select sum(total_payment) AS MTD_Total_Amount_Applications from bank_loan_data
where MONTH(issue_date) = 12 AND year(issue_date) = 2021;
```

**previous month to date total payment of loan**:
```sql
select sum(total_payment) AS PMTD_Total_Amount_Applications from bank_loan_data
where MONTH(issue_date) = 11 AND year(issue_date) = 2021;
```

**current month to average date**:
```sql
select round(AVG(int_rate)*100, 2) as MTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) =2021;
```

**previous month to date average date**:
```sql
select round(AVG(int_rate)*100, 2) as PMTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) =2021;
```

### dti should not very much high or not very much low

**Debt to income ratio**:
```sql
SELECT ROUND(avg(dti)*100, 2) as MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) =12 and year(issue_date) = 2021
```

**FOR PREVIOUS MONTH debt to income ratio**:
```sql
SELECT ROUND(avg(dti)*100, 2) as PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 and year(issue_date) = 2021
```

**find loan status**
```sql
select loan_status from bank_loan_data
```

## good loan ={[count of (fully paid loan status and current loan status)]/ [count(id)]}*100:

```sql
select
     (COUNT(case when loan_status ='Fully Paid' or loan_status = 'Current' then id end)*100)
	 /
	 COUNT(id) as Good_loan_percentage
from bank_loan_data;
```

**good loan application**:
```sql
select count(id) as Good_Loan_Applications from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';
```

**find the good loan funded amount meand the loan amount**
```sql
select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';
```

**ind god loan total received amount**:
```sql
select sum(total_payment) as Good_Loan_amount_received from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';
```

### BAD LOAN RECEIVED

**Bad loan percentage**:
```sql
select
     (COUNT(case when loan_status ='Charged Off' then id end)*100)
	 /
	 COUNT(id) as Bad_loan_percentage
from bank_loan_data;
```

**total applications of bad loan**:
```sql
select count(id) as Bad_Loan_Applications from bank_loan_data
where loan_status='charged Off'
```

**bad loan funded amount**:
```sql
select sum(total_payment) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status='charged Off';
```

**LOAN STATUS**:
```sql
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
```

**month to date total amount received and month to date total amount funded**:
```sql
select 
      loan_status,
	  SUM(total_payment) as MTD_Total_Received,
	  SUM(loan_amount) as MTD_Total_Funded_Amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status;
```

### OVERVIEW 

**monthly trends by issue date**:
```sql
SELECT
     MONTH(issue_date) as Month_Number,
     DATENAME(MONTH, issue_date) as Month_Name,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by MONTH(issue_date), DATENAME(month, issue_date)
order by month(issue_date);
```

**regional analysis by state**:
```sql
SELECT
     address_state,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by address_state
order by address_state;
```

**LOAN TERM ANALYSIS - to allow the client to understand the distribution of loans across various term lengths**:
```sql
SELECT
     term,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by term
order by term;
```
 
```sql
SELECT
     emp_length,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by emp_length
order by count(id) desc;
```

```sql
SELECT
     home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by home_ownership
order by count(id) desc;
```

```sql
SELECT
     home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
where grade = 'A' 
group by home_ownership
order by count(id) desc;
```

```sql
SELECT
   home_ownership,
	 COUNT(id) as Total_Loan_Applications,
	 sum(loan_amount) as Total_Funded_Amount,
	 sum(total_payment) as Total_Received_Amount
from bank_loan_data
where grade = 'A' and address_state ='CA'
group by home_ownership
order by count(id) desc;
```

# EXCEL VISUALISATION / DASHBOARD

## DASHBOARD LINK

<a href="https://github.com/SnehalDeepa/bank_loan_analysis1/blob/main/BANK%20LOAN%20DASH.xlsx">view Dashboard<a/>

# PYTHON CODE

## STEP_1) DATA PREPARATION

### Import Libraries

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```
### Set Plot Style

```python
sns.set(style="whitegrid")
```

### Load The Data

```python
df = pd.read_csv("Electric_Vehicle_Population_Data.csv")
```
```python
df.head()
```
