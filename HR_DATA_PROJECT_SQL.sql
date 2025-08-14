CREATE TABLE HR_data (
    Age INT,
    Attrition TEXT,
    BusinessTravel TEXT,
    DailyRate INT,
    Department TEXT,
    DistanceFromHome INT,
    Education INT,
    EducationField TEXT,
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender TEXT,
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole TEXT,
    JobSatisfaction INT,
    MaritalStatus TEXT,
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 TEXT,
    OverTime TEXT,
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);
SELECT*FROM HR_data;

-- 1. Total number of employees in the dataset
SELECT COUNT(*) AS total_employees FROM HR_data;

-- 2. How many employees left the company (Attrition = 'Yes')?
SELECT COUNT(*) AS attrition_count
FROM HR_data
WHERE Attrition = 'Yes';

-- 3. Show the average age of employees in each department.
SELECT Department, AVG(Age) AS avg_age
FROM HR_data
GROUP BY Department;

-- 4. List all job roles with the highest attrition rate.
SELECT JobRole, 
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR_data
GROUP BY JobRole
ORDER BY attrition_rate DESC;

-- 5. Which department has the highest average monthly income?
SELECT Department, AVG(MonthlyIncome) AS avg_income
FROM HR_data
GROUP BY Department
ORDER BY avg_income DESC
LIMIT 1;

-- 6. Find employees with more than 10 years at company and less than 2 promotions.
SELECT EmployeeNumber, JobRole, YearsAtCompany, YearsSinceLastPromotion
FROM HR_data
WHERE YearsAtCompany > 10 AND YearsSinceLastPromotion < 2;

-- 7. Show average income by gender and marital status.
SELECT Gender, MaritalStatus, AVG(MonthlyIncome) AS avg_income
FROM HR_data
GROUP BY Gender, MaritalStatus;

-- 8. Get top 5 earning employees with attrition = 'Yes'
SELECT EmployeeNumber, JobRole, MonthlyIncome
FROM HR_data
WHERE Attrition = 'Yes'
ORDER BY MonthlyIncome DESC
LIMIT 5;

-- 9. Find total working years for each education field.
SELECT EducationField, SUM(TotalWorkingYears) AS total_years
FROM HR_data
GROUP BY EducationField;

-- 10. How many employees are working overtime in each department?
SELECT Department, COUNT(*) AS overtime_employees
FROM HR_data
WHERE OverTime = 'Yes'
GROUP BY Department;

-- 11. Which job role has the highest job satisfaction (on average)?
SELECT JobRole, AVG(JobSatisfaction) AS avg_satisfaction
FROM HR_data
GROUP BY JobRole
ORDER BY avg_satisfaction DESC;

-- 12. List employees who earn more than the average income.
SELECT EmployeeNumber, JobRole, MonthlyIncome
FROM HR_data
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome) FROM HR_data
);
-- 13. Rank employees by Monthly Income within each Department
SELECT 
    EmployeeNumber,
    Department,
    MonthlyIncome,
    RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS income_rank
FROM HR_data;

-- 14. Running total of Monthly Income across all employees (sorted by income)
SELECT 
    EmployeeNumber,
    MonthlyIncome,
    SUM(MonthlyIncome) OVER (ORDER BY MonthlyIncome) AS running_total
FROM HR_data;





