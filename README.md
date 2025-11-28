# Project Objective
1. Analyze credit card transaction data to generate actionable insights on spending behavior.
2. Identify top cities, months, and card types based on transaction volume and spend patterns.
3. Evaluate cumulative spending trends across different card types to detect high-value transactions.
4. Compare spending habits across demographics (like gender) and expense categories.
5. Investigate time-based and city-wise patterns, including weekend transactions and transaction velocity.

# Purpose of this credit card analytics project
Empower financial institutions and businesses to monitor customer spending habits, identify high-value markets and optimize promotions or offers based on transaction data.

# Importance of analyzing credit card transactions
1. Determine top-performing cities, months, and card types.
2. Track spending trends by expense type to enhance customer targeting.
3. Identify patterns in cumulative transactions to flag high-value customers.

## 📦 Dataset

**Source**: [Kaggle Dataset](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india)

- Columns cleaned: lowercase + spaces replaced with underscores
- Imported into SQL Server table

## 🛠 Tools

- SQL Server
- MS Excel

## 🧹 Data Preparation

- Removed nulls and cleaned column names
- Converted data types appropriately (e.g., `amount` to `FLOAT`, `date` to `DATETIME`)

## 📊 Key Business Questions Solved

| # | Question |
|---|----------|
| 1 | Top 5 cities with highest spends and % contribution |
| 2 | Highest spend month for each card type |
| 3 | Transaction when each card reached ₹1M cumulative |
| 4 | City with lowest % gold card spend |
| 5 | City-wise highest and lowest expense types |
| 6 | Female spend contribution by expense type |
| 7 | Highest MoM growth (Jan 2014) by card + expense type |
| 8 | Weekend city with highest spend/transaction ratio |
| 9 | City that reached 500th transaction fastest |

## 📈 Summary of Findings

- **Mumbai** contributes the most to total credit card spends.
- **Fuel** is the most common expense type.
- **Platinum cards** saw the highest growth in Jan 2014.
- **Delhi** has the highest weekend spend efficiency.
- **Chennai** reached 500 transactions the fastest after first txn.


