CREATE TABLE Employee2(
	EmployeeID NVARCHAR(250) , 
	FirstName NVARCHAR(250) , 
	LastName NVARCHAR(250) , 
	Gender NVARCHAR(250) , 
	Age NVARCHAR(250) , 
	BusinessTravel NVARCHAR(250) , 
	Department NVARCHAR(250) , 
	[DistanceFromHome (KM)] NVARCHAR(250) , 
	State NVARCHAR(250) , 
	Ethnicity NVARCHAR(250) , 
	Education NVARCHAR(250) , 
	EducationField NVARCHAR(250) , 
	JobRole NVARCHAR(250) , 
	MaritalStatus NVARCHAR(250) , 
	Salary NVARCHAR(250) , 
	StockOptionLevel NVARCHAR(250) , 
	OverTime NVARCHAR(250) , 
	HireDate NVARCHAR(250) , 
	Attrition NVARCHAR(250) , 
	YearsAtCompany NVARCHAR(250) , 
	YearsInMostRecentRole NVARCHAR(250) , 
	YearsSinceLastPromotion NVARCHAR(250) , 
	YearsWithCurrManager NVARCHAR(250) 


)
SELECT *
FROM Employee2

BULK INSERT Employee2
FROM 'C:\Users\ASUS\Downloads\Employee(1).csv' -- Reemplaza con la ruta real
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           -- Ignora el encabezado del CSV
    FIELDTERMINATOR = ',',  -- Cambia por ';' si tu CSV usa punto y coma
    ROWTERMINATOR = '\n' -- Salto de línea estándar (LF) o '\n'
   -- ENCODING = 'UTF-8'      -- Importante si tienes acentos o tildes
 
);
SELECT *
FROM Employee2