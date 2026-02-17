# Ola_Booking_Analysis:Bengaluru case study

An end-to-end data analysis project using SQL for Exploratory Data Analysis (EDA) and Power BI for interactive visualization of 100,000+ ride-booking records.

**📌 Project Overview**

This project analyzes a dataset of 1 Lac (100,000) Ola booking rows for Bengaluru, India. The objective is to identify key performance indicators (KPIs) such as

booking success rates, cancellation trends, revenue distribution, and customer/driver ratings to drive operational improvements.

**🛠️ Tech Stack & Tools**

**Database:** PostgreSQL (Data Storage & EDA)

**Visualization:** Power BI (Interactive Dashboard)

**Data Source:** CSV file (100,000 rows)

**🗂️ Data Pipeline & Challenges**

**Table Schema Design:** Defined a structured schema in PostgreSQL to handle various data types including timestamps, strings, and decimals.

**Challenge - Date Formatting:** PostgreSQL's default date style (ISO) conflicted with the source CSV's Day-Month-Year (DMY) format.

**Solution:** Used SET datestyle TO 'ISO, DMY'; temporarily during the bulk import process.

**Data Import:** Utilized the COPY command for high-speed bulk data ingestion from the local directory.

**EDA with SQL:** Created 12 specialized Views to modularize the analysis for successful rides, cancellations, and revenue breakdown.

**📊 Key Insights (Business Findings)**

**Revenue Anchor:** "Prime Sedan" is the top-performing category, contributing 14.89% of total revenue.

**High Cancellation Rates:** The overall cancellation rate is 28.08%. Notably, Driver cancellations (17.89%) are higher than Customer cancellations (10.19%).

**Operational Pain Points:**

The #1 customer cancellation reason is "Driver is not moving towards pickup location" (30.24%).

The primary driver cancellation reason is "Personal & Car related issues" (35.49%).

**Payment Trends:** UPI has emerged as a significant payment method, providing insights into the popularity of digital transactions.

**📈 Dashboard Features**

The Power BI dashboard provides five distinct analytical views:

**Overall:** High-level KPIs (Total Bookings: 103,024).

**Vehicle Type:** Deep dive into how different categories (Mini, Sedan, SUV, Auto) perform.

**Revenue:** Financial metrics including total booking value and percentage contribution.

**Cancellations:** Comparative analysis of customer vs. driver cancellation reasons.

**Ratings:** Analysis of driver and customer satisfaction levels.

**🚀 How to Replicate**
**SQL Setup:** Execute the SQL script provided in the repository to set up the database and create all views.

**Data Ingestion:** Update the file path in the COPY command to point to your local dataset.

**Visualization:** Open the .pbix file in Power BI Desktop to explore the interactive dashboard.

