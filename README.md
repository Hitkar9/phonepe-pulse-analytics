# 📱 PhonePe Pulse: Transaction Growth & User Analytics

![SQL](https://img.shields.io/badge/SQL-Microsoft%20SQL%20Server-blue?style=for-the-badge&logo=microsoftsqlserver)
![Python](https://img.shields.io/badge/Python-3.10-green?style=for-the-badge&logo=python)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?style=for-the-badge&logo=powerbi)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## 📌 Project Overview

End-to-end **Product Analytics** project analyzing PhonePe's real public Pulse dataset combined with **50,000 synthetic users** built on NPCI/UPI industry benchmarks.

This project simulates the work of a **Data/Product Analyst at a fintech company** — from raw data ingestion to business insights and dashboard reporting.

---

## ❓ Business Questions Answered

| # | Question |
|---|----------|
| 1 | Which states are driving PhonePe's growth? |
| 2 | Where does the user funnel drop off? |
| 3 | Does cashback improve user retention? |
| 4 | Which user segments churn the most? |
| 5 | What is PhonePe's market opportunity in underpenetrated states? |

---

## 🔍 Key Findings

| Metric | Value | Insight |
|--------|-------|---------|
| 🚀 Transaction Growth | ![91x](https://img.shields.io/badge/91x-Growth-success?style=for-the-badge) | PhonePe grew 91x from 2018 to 2024 |
| ⚡ Biggest Spike | ![2021](https://img.shields.io/badge/2021-COVID%20Boom-blue?style=for-the-badge) | Post-COVID digital payments explosion |
| 🚨 Funnel Drop-off | ![22.5%](https://img.shields.io/badge/22.5%25-KYC%20→%20Bank%20Link-red?style=for-the-badge) | Biggest friction point in user journey |
| 💰 Cashback Impact | ![73%](https://img.shields.io/badge/73%25-More%20Transactions-orange?style=for-the-badge) | Cashback users transact 73% more |
| 👑 Power Users | ![42x](https://img.shields.io/badge/42x-Higher%20Spend-purple?style=for-the-badge) | Top 10% spend 42x vs bottom 10% |
| ⚠️ Churn Rate | ![19.44%](https://img.shields.io/badge/19.44%25-Overall%20Churn-critical?style=for-the-badge) | Jharkhand highest at 21.17% |

---

### 📈 Transaction Growth (2018–2024)
```
2018  ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░   4%
2019  ████░░░░░░░░░░░░░░░░░░░░░░░░░░   12%
2020  ██████░░░░░░░░░░░░░░░░░░░░░░░░   22%
2021  ███████████████░░░░░░░░░░░░░░░   54%  ⚡ COVID Boom
2022  ████████████████████░░░░░░░░░░   68%
2023  █████████████████████████░░░░░   82%
2024  ██████████████████████████████   91x 🚀
```

### 🚨 Churn Rate by State (Top 5)
```
Jharkhand   ████████████████████████   21.17%  🔴
Bihar       ███████████████████████░   20.89%  🔴
UP          ██████████████████████░░   20.12%  🟠
MP          █████████████████████░░░   19.98%  🟠
Overall     ████████████████████░░░░   19.44%  🟡
```

---

## 📊 SQL Analysis Modules

| # | File | Focus Area | Key Metrics | Complexity |
|---|------|-----------|-------------|------------|
| 01 | `01_eda_queries.sql` | Data Profiling | Row counts, distributions, date ranges | ⭐⭐ |
| 02 | `02_growth_analysis.sql` | Growth Trends | YoY growth, state-wise performance | ⭐⭐⭐ |
| 03 | `03_funnel_retention.sql` | Funnel Analysis | Conversion rates, retention cohorts | ⭐⭐⭐⭐ |
| 04 | `04_cohort_churn.sql` | Churn Analysis | Churn rate, cohort LTV, segments | ⭐⭐⭐⭐ |
| 05 | `05_product_metrics.sql` | Product KPIs | DAU/WAU/MAU, ARPU, CLV, RFM | ⭐⭐⭐⭐⭐ |

---

## 🗂️ Project Structure

```
phonepe-pulse-analytics/
│
├── 📁 data/                        # Raw datasets
├── 📁 notebooks/
│   ├── 01_data_loading.ipynb       # Data ingestion & setup
│   └── 02_synthetic_data.ipynb     # Synthetic user generation
│
├── 📁 sql/
│   ├── 01_eda_queries.sql          # Exploratory Data Analysis
│   ├── 02_growth_analysis.sql      # Transaction growth trends
│   ├── 03_funnel_retention.sql     # Funnel & retention analysis
│   ├── 04_cohort_churn.sql         # Cohort & churn analysis
│   └── 05_product_metrics.sql      # DAU/WAU/MAU, ARPU, CLV, RFM
│
├── 📁 visualizations/              # Charts & dashboard exports
├── 📁 findings/                    # Business insight reports
└── README.md
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| ![SQL Server](https://img.shields.io/badge/-SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white) | Database & query execution |
| ![Python](https://img.shields.io/badge/-Python-3776AB?style=flat&logo=python&logoColor=white) | Data generation & EDA |
| ![Power BI](https://img.shields.io/badge/-Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black) | Dashboard & visualization |
| ![VS Code](https://img.shields.io/badge/-VS%20Code-007ACC?style=flat&logo=visualstudiocode&logoColor=white) | Development environment |
| ![Jupyter](https://img.shields.io/badge/-Jupyter-F37626?style=flat&logo=jupyter&logoColor=white) | Notebook analysis |

---

## 👤 Author

**Himanshu Hitkar**
Student — NIT Patna | Aspiring Data/Product Analyst

[![GitHub](https://img.shields.io/badge/GitHub-Hitkar9-black?style=flat&logo=github)](https://github.com/Hitkar9)
