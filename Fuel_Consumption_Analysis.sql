SELECT TOP (1000) [YEAR]
      ,[MAKE]
      ,[MODEL]
      ,[VEHICLE_CLASS]
      ,[ENGINE_SIZE]
      ,[CYLINDERS]
      ,[TRANSMISSION]
      ,[FUEL]
      ,[FUEL_CONSUMPTION]
      ,[HWY_L_100_km]
      ,[COMB_L_100_km]
      ,[COMB_mpg]
      ,[EMISSIONS]
  FROM [MyProject].[dbo].[Fuel_Consumption_2000-2022]



---1. Trends in Average Fuel Consumption by Year:
SELECT YEAR, AVG(COMB_L_100_km) AS Avg_Fuel_Consumption
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY YEAR
ORDER BY YEAR ASC;


---2. Comparison of Average Fuel Consumption by Vehicle Class:
SELECT VEHICLE_CLASS, AVG(COMB_L_100_km) AS Avg_Fuel_Consumption
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY VEHICLE_CLASS;


---3. Average CO2 Emissions by Year:
SELECT YEAR, AVG(EMISSIONS) AS Avg_Emissions
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY YEAR
ORDER BY YEAR ASC;


---4. Average Engine Size and Number of Cylinders by Vehicle Class:
SELECT VEHICLE_CLASS, AVG(ENGINE_SIZE) AS Avg_Engine_Size, AVG(CYLINDERS) AS Avg_Cylinders
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY VEHICLE_CLASS
ORDER BY AVG(ENGINE_SIZE) DESC;


---5. Most and Least Fuel Efficient Vehicles:
SELECT TOP 1 MAKE, MODEL, COMB_L_100_km
FROM dbo.[Fuel_Consumption_2000-2022]
ORDER BY COMB_L_100_km ASC;

SELECT TOP 1 MAKE, MODEL, COMB_L_100_km
FROM dbo.[Fuel_Consumption_2000-2022]
ORDER BY COMB_L_100_km DESC;



---6 Fuel Consumption Distribution by Fuel Type:
SELECT FUEL, AVG(COMB_L_100_km) AS Avg_Fuel_Consumption
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY FUEL
ORDER BY AVG(COMB_L_100_km) DESC;


---7 Engine size and fuel consumption
SELECT ENGINE_SIZE, COMB_L_100_km
FROM dbo.[Fuel_Consumption_2000-2022];

---8. Number of Vehicles by Make and Year:
SELECT YEAR, MAKE, COUNT(*) AS Number_of_Vehicles
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY YEAR, MAKE
ORDER BY Number_of_Vehicles DESC;



---9. Impact of Transmission Type on Fuel Efficiency:
SELECT TRANSMISSION, AVG(COMB_L_100_km) AS Avg_Fuel_Efficiency
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY TRANSMISSION
ORDER BY AVG(COMB_L_100_km) DESC;



---10. Change in Average Fuel Efficiency Over Time for Top 5 Makes:
---First, find the top 5 makes:
SELECT TOP 5 MAKE, COUNT(*) AS Total_Vehicles
FROM dbo.[Fuel_Consumption_2000-2022]
GROUP BY MAKE
ORDER BY Total_Vehicles DESC;


---Then, for each of these makes, we analyze the change over time:
WITH TopMakes AS (
    SELECT TOP 5 MAKE 
    FROM dbo.[Fuel_Consumption_2000-2022]
    GROUP BY MAKE
    ORDER BY COUNT(*) DESC
)
SELECT YEAR, MAKE, AVG(COMB_L_100_km) AS Avg_Fuel_Efficiency
FROM dbo.[Fuel_Consumption_2000-2022]
WHERE MAKE IN (SELECT MAKE FROM TopMakes)
GROUP BY YEAR, MAKE;

