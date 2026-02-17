                                       --CREATING TABLE TO STORE DATA
CREATE TABLE Booking(
Date timestamp,
Time time,
Booking_ID varchar(20),
Booking_Status varchar(30),
Customer_ID varchar(30),
Vehicle_Type varchar(20),
Pickup_Location varchar(100),
Drop_Location varchar(100),
V_TAT INT,
C_TAT INT,
Canceled_Rides_by_Customer varchar(100),
Canceled_Rides_by_Driver varchar(100),
Incomplete_Rides varchar(15),
Incomplete_Rides_Reason varchar(150),
Booking_Value int,
Payment_Method varchar(20),
Ride_Distance INT,
Driver_Ratings decimal(3,1),
Customer_Rating decimal(3,1)
);   

select * from booking;


--PostgreSQL's default date style is usually ISO, MDY or ISO, YMD, so must explicitly tell it to 
--use Day-Month-Year (DMY) format temporarily.because we are importing the csv data in that date is DMY;

SET datestyle TO 'ISO, DMY';

                        --BULK INSERT METHOD FOR DATA IMPORT
COPY booking 
FROM 'D:\ola bookings.csv' 
WITH (FORMAT CSV, HEADER, NULL 'null');

                       --EXPLORATION DATA ANALYSIS (EDA)
					   
--Q1. Retrieve all successful bookings:
CREATE View Successful_Bookings AS
SELECT * FROM Booking
WHERE booking_status='Success';
--ANS:Retrieve all successful bookings:
SELECT * FROM Successful_Bookings;

--Explanation: This query retrieves all the booking details where the status is marked as "Success," providing
--insights into completed rides.
--Q2. Find the average ride distance for each vehicle type:

CREATE View average_ride_distance AS
SELECT vehicle_Type,
       ROUND(AVG(ride_distance),2)AS avg_ride
       FROM Booking
       GROUP BY Vehicle_Type
	   ORDER BY avg_ride DESC;
SELECT * FROM average_ride_distance;

--Explanation: This query calculates the average ride distance for each type of vehicle, helping analyze
--performance and customer preferences by vehicle category.

--Q3. Get the total number of cancelled rides by customers:

CREATE View Canceled_by_Customers AS
 SELECT COUNT(Canceled_Rides_by_Customer) AS cancelled_by_customer 
 FROM Booking
 WHERE Booking_Status='Canceled by Customer';
 
 SELECT * FROM Canceled_by_Customers;
 --Explanation: This query counts the total number of rides cancelled by customers, useful for understanding customer behaviour 
 --and cancellation trends.

 --Q4. List the top 5 customers who booked the highest number of rides:
 
 SELECT * FROM Booking;
 
 CREATE View Top_5_Customer AS
 SELECT Customer_ID,
 COUNT(Booking_ID)AS Total_rides
 FROM Booking
 GROUP BY Customer_ID
 ORDER BY Total_rides DESC
 LIMIT 5;
 --Explanation: This query identifies the top 5 customers based on the number of rides booked, highlighting the most active users.
 
 SELECT * FROM Top_5_Customer;
 --Query 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

 select * from booking;

CREATE View Canceled_by_Driver AS
SELECT COUNT(Canceled_rides_by_driver) as total_cancel_by_driver
FROM Booking
WHERE Canceled_Rides_by_Driver='Personal & Car related issue'
 
 SELECT * FROM Canceled_by_Driver;
 
--Explanation: This query calculates the number of rides canceled by drivers due to personal or car-related reasons,
--helping identify operational issues.

--Q6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT * FROM Booking;

CREATE View Max_Min_Driver_Rating AS
SELECT MAX(Driver_Ratings)AS Max_rating,
MIN(Driver_Ratings)AS Min_rating
FROM Booking
WHERE Vehicle_Type='Prime Sedan';

SELECT * FROM Max_Min_Driver_Rating;

--Explanation: This query finds the highest and lowest driver ratings for Prime Sedan bookings, helping assess service
--quality for this vehicle type.

--Q7. Retrieve all rides where payment was made using UPI:

SELECT * FROM Booking;
CREATE View UPI_Method AS
SELECT * FROM Booking
WHERE Payment_Method='UPI';

SELECT * FROM UPI_Method;

--Explanation: This query retrieves all ride details where the payment method was made using UPI by providing insights
--into the popularity of digital payment modes.

--Q8. Find the average customer rating per vehicle type:

SELECT * FROM Booking;

CREATE View avg_Cust_Rating AS
SELECT Vehicle_Type,
ROUND(AVG(Customer_Rating),2)AS Avg_Rating
FROM Booking
GROUP BY Vehicle_Type;

SELECT * FROM Avg_Cust_Rating;

--Explanation: This query calculates the average customer rating for each vehicle type, helping evaluate customer
--satisfaction across different categories.

--Q9. Calculate the total booking value of rides completed successfully:

SELECT * FROM Booking;

CREATE View Total_Revenue AS
SELECT SUM(Booking_Value)AS Total_Value
FROM Booking
WHERE Booking_Status='Success';

SELECT * FROM Total_Revenue;

--Explanation: This query computes the total revenue generated from successfully completed rides,
--providing key financial metrics.

--Q10.Calculate the total booking value of rides completed successfully for each vehicle type:

SELECT * FROM Booking;


CREATE View Total_Revenue_by_each_Vehicle AS
SELECT Vehicle_type,SUM(Booking_Value)AS Total_Revenue
FROM Booking
WHERE Booking_Status='Success'
GROUP BY vehicle_type
ORDER BY  total_Revenue DESC;

SELECT * FROM Total_Revenue_by_each_Vehicle;

--Q11.Calculate the total booking value of rides completed successfully for each vehicle type with revenue cont_breakdown:
CREATE View Revenue_cont_Breakdown AS
SELECT 
    vehicle_type, 
    SUM(booking_value) AS revenue,
    ROUND(
        (SUM(booking_value) * 100.0) / SUM(SUM(booking_value)) OVER (), 
        2
    ) AS percentage_contribution
FROM Booking
WHERE Booking_Status='Success'
GROUP BY vehicle_type
ORDER BY revenue DESC;

SELECT * FROM Revenue_cont_Breakdown;
-- Revenue Contribution Breakdown
--Performance: "Prime Sedan" is our top-performing category, contributing ₹5.22M in revenue and holding the largest market
--share at 14.89%.
--Insight: This suggests our core customer base prefers a balance of comfort and affordability.
--It is the "anchor" of our business.



--Q12. List all incomplete rides along with the reason:

SELECT * FROM Booking;

CREATE View Incomplete_Rides AS
SELECT Booking_ID,
Incomplete_Rides_Reason
FROM Booking
WHERE Incomplete_Rides='Yes';

SELECT * FROM Incomplete_Rides;

--Explanation: This query lists all incomplete rides along with the reasons, helping identify and address 
--the root causes of incomplete rides.


--Answering all the related question with the view to simplify it to every one.
--Q1. Retrieve all successful bookings:
SELECT * FROM Successful_Bookings;

--Q2. Find the average ride distance for each vehicle type:
SELECT * FROM average_ride_distance;

--Q3. Get the total number of canceled rides by customers:
SELECT * FROM Canceled_by_Customers;

--Q4. List the top 5 customers who booked the highest number of rides:
 SELECT * FROM Top_5_Customer;

--Q5. Get the number of rides cancelled by drivers due to personal and car-related issues:
 SELECT * FROM Cancelled_by_Driver;

--Q6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM Max_Min_Driver_Rating;

--Q7. Retrieve all rides where payment was made using UPI:
SELECT * FROM UPI_Method;

--Q8. Find the average customer rating per vehicle type:
SELECT * FROM Avg_Cust_Rating;

--Q9. Calculate the total booking value of rides completed successfully:
SELECT * FROM Total_Revenue;

--Q10.Calculate the total booking value of rides completed successfully for each vehicle type:
SELECT * FROM Total_Revenue_by_each_Vehicle;

--Q11.Calculate the total booking value of rides completed successfully for each vehicle type with revenue cont_breakdown:
SELECT * FROM Revenue_cont_Breakdown;

--Q12. List all incomplete rides along with the reason:
SELECT * FROM Incomplete_Rides;










