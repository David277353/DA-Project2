# Smartphone Sales & Customer Behavior Analysis

SQL and BigQuery analysis of a phone market dataset to uncover sales trends,
customer segmentation, and brand loyalty insights.

## 📋 Description

This project was completed as a **Hackathon SQL Midterm** challenge. It analyzes
100,000+ smartphone transaction records to identify purchasing patterns by gender,
age group, and payment method — providing actionable insights for marketing and
sales strategy.

## 🛠️ Technologies Used

- **Database:** Google BigQuery
- **Dataset:** `nakt-991762341.hometest.hackathon_phone_sales`
- **Language:** SQL (BigQuery dialect)

## 📁 File Structure
phone-market-analysis/
├── Hackathon_PhoneMarket.sql      # All queries with comments and explanations
└── dataset 

## 🚀 How to Run

1. Go to [Google BigQuery Console](https://console.cloud.google.com/bigquery)
2. Load the phone sales dataset into your BigQuery project
3. Open a new query editor and paste any query from the `.sql` file
4. Update the dataset reference to match your project if needed

## 📊 Analysis Covered

| # | Question | Technique |
|---|----------|-----------|
| Q1 | Number of orders per month | Aggregation, DATE parsing |
| Q2 | Number of unique customers per month | Aggregation, COUNT DISTINCT |
| Q3 | Top 3 preferred phone brands by gender | CTE, Window Function, ROW_NUMBER |
| Q4 | Age group with most purchases & highest revenue | Aggregation, SUM |
| Q5 | Top 3 revenue-generating products per month | CTE, Window Function, RANK |
| Q6 | Preferred brands among 26–30 age group | Aggregation, COUNT DISTINCT |
| Q10 | Most purchased brand via installment payment | Aggregation, WHERE filter |

## ✨ Key Findings

- **Samsung and Nokia** emerged as the preferred brands across key demographic segments
- The **26–30 age group** was identified as the primary driver for high-margin product adoption
- **Installment payment (Trả góp)** analysis revealed brand preferences for budget-conscious buyers
- Customer segmentation by age and gender provided targeted insights for marketing outreach

## ✨ Key Features

- **ROW_NUMBER & RANK** Window Functions for monthly and demographic rankings
- **CTE (Common Table Expressions)** to break down complex multi-step queries
- **Customer segmentation** by age group and gender across 100,000+ records
- **Revenue and volume analysis** combined to distinguish high-frequency vs high-value segments

## 🗓️ Timeline

**January 2026 – February 2026** | Hackathon SQL Midterm

## 👤 Author

**Khoa Tran**  
