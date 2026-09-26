# CAC-Data-Engineering-and-Analytics-Platform

An end-to-end **data engineering and analytics platform** for automating Customer Acquisition Cost (CAC) analysis.

The project evolved from an exploratory **Python/Jupyter analysis** into a complete **Talend → Snowflake → Tableau** data pipeline covering data ingestion, validation, ETL, cloud data warehousing, SQL transformations, analytical aggregation, and business intelligence.

**Pipeline:** CSV → Talend ETL → Snowflake RAW → STAGING → ANALYTICS → Tableau

**Focus:** ETL • Data Quality • Data Warehousing • SQL • Analytics • Business Intelligence

---

## Project Overview

Customer Acquisition Cost (CAC) is a key marketing metric that measures the cost required to acquire new customers.

This project began as a Python-based CAC analysis and was expanded into a data engineering workflow that separates exploratory analysis from the production-style ETL and analytics pipeline.

The complete workflow is:

**Python Analysis → Talend ETL → Snowflake → SQL Analytics → Tableau**

The platform supports:

* Data exploration and analysis
* Customer acquisition cost calculation
* Data ingestion
* Data validation
* Rejected-record handling
* ETL processing
* Snowflake data warehousing
* SQL-based transformations
* Analytical aggregation
* Interactive business intelligence

---

## Architecture

```text
                         SOURCE DATA
                              │
                              ▼
              customer_acquisition_cost_dataset.csv
                              │
               ┌──────────────┴──────────────┐
               │                             │
               ▼                             ▼
       Python / Pandas                Talend ETL
       Jupyter / Plotly                    │
               │                           │
               │                    ┌──────┴──────┐
               │                    │             │
               │                    ▼             ▼
               │              Valid Records   Rejected Records
               │                    │             │
               │                    ▼             ▼
               │              SNOWFLAKE RAW   data/rejects/
               │                    │
               │                    ▼
               │              SNOWFLAKE STAGING
               │                    │
               │                    ▼
               │              SNOWFLAKE ANALYTICS
               │                    │
               │                    ▼
               │             TABLEAU EXECUTIVE
               │                DASHBOARD
               │
               ▼
        Original CAC Analysis
```

---

## Repository Structure

```text
CAC-Automation-and-Visualization-Platform/
│
├── data/
│   ├── raw/
│   └── rejects/
│
├── talend/
│   ├── jobs/
│   └── schemas/
│
├── snowflake/
│   ├── 01_database.sql
│   ├── 02_raw.sql
│   ├── 03_staging.sql
│   ├── 04_analytics.sql
│   └── 05_tasks.sql
│
├── screenshots/
│   ├── CAC Executive Dashboard_SS.png
│   ├── New Customers by Marketing Channel_SS.png
│   ├── Marketing Spend by Channel_SS.png
│   └── CAC by Marketing Channel_SS.png
│
├── CAC.ipynb
├── CAC_Executive_Dashboard.twbx
└── README.md
```

---

## Python / Jupyter Analysis

The original analytical foundation is contained in `CAC.ipynb`, using **Python, Pandas, and Plotly**.

### Notebook Workflow

* Loads and explores the customer acquisition dataset
* Calculates Customer Acquisition Cost (CAC)
* Analyzes CAC across marketing channels
* Visualizes CAC by channel
* Analyzes the relationship between new customers and CAC
* Performs scatter-plot trendline analysis
* Generates CAC summary statistics by channel
* Analyzes conversion rates by channel
* Calculates break-even customers
* Compares actual vs. break-even customers
* Creates interactive Plotly visualizations

The notebook represents the project's original exploratory analytics stage, while the Talend and Snowflake pipeline provides the subsequent data engineering workflow.

---

## Technologies

| Category       | Technologies             |
| -------------- | ------------------------ |
| Programming    | Python                   |
| ETL            | Talend Open Studio       |
| Data Warehouse | Snowflake                |
| Query Language | SQL                      |
| Data Analysis  | Pandas, Jupyter Notebook |
| Visualization  | Plotly, Tableau          |
| Storage        | CSV, Snowflake           |

---

## ETL Pipeline

The Talend pipeline is responsible for ingesting, validating, and routing the source data.

### Talend Job

`JOB_CAC_CSV_TO_SNOWFLAKE_RAW_MAIN`

### Responsibilities

* Reads the source CSV
* Validates customer IDs
* Validates supported marketing channels
* Validates marketing spend
* Validates new customer values
* Routes valid records to Snowflake
* Routes invalid records to a rejected-record CSV

### Supported Marketing Channels

* Email Marketing
* Online Ads
* Referral
* Social Media

### Data Quality Rules

Talend validates:

* Customer ID is not empty
* Marketing channel belongs to the supported channel list
* Marketing spend is non-negative
* New customer count is positive

Invalid records are separated from the main ingestion flow for traceability and review.

Rejected records are written to:

```text
data/rejects/customer_acquisition_cost_rejects.csv
```

---

## Snowflake Architecture

The Snowflake implementation follows a layered data-warehouse structure.

| Layer     | Purpose                              | SQL Script                   |
| --------- | ------------------------------------ | ---------------------------- |
| RAW       | Validated data received from Talend  | `snowflake/02_raw.sql`       |
| STAGING   | Structured and transformed data      | `snowflake/03_staging.sql`   |
| ANALYTICS | Business-ready analytical metrics    | `snowflake/04_analytics.sql` |
| Tasks     | Automated Snowflake task definitions | `snowflake/05_tasks.sql`     |
| Database  | Database and warehouse setup         | `snowflake/01_database.sql`  |

### Data Flow

```text
Talend
   │
   ▼
Snowflake RAW
   │
   ▼
Snowflake STAGING
   │
   ▼
Snowflake ANALYTICS
   │
   ▼
Tableau
```

This layered approach separates ingestion, transformation, and business-level analytical data.

---

## Tableau Executive Dashboard

The final analytical output is presented through an interactive Tableau executive dashboard.

Workbook:

```text
CAC_Executive_Dashboard.twbx
```

### Key Performance Indicators

* Total Customers
* Total Marketing Spend
* Total New Customers
* Overall Average CAC

### Visualizations

* New Customers by Marketing Channel
* Marketing Spend by Marketing Channel
* Customer Acquisition Cost by Marketing Channel

The dashboard supports marketing-channel filtering for interactive analysis.

The `.twbx` workbook contains embedded Tableau extracts for demonstration without requiring a live Snowflake connection.

---

## Dashboard Preview

### Executive Dashboard

![CAC Executive Dashboard](screenshots/CAC%20Executive%20Dashboard_SS.png)

### New Customers by Marketing Channel

![New Customers by Marketing Channel](screenshots/New%20Customers%20by%20Marketing%20Channel_SS.png)

### Marketing Spend by Channel

![Marketing Spend by Channel](screenshots/Marketing%20Spend%20by%20Channel_SS.png)

### CAC by Marketing Channel

![CAC by Marketing Channel](screenshots/CAC%20by%20Marketing%20Channel_SS.png)

---

## End-to-End Data Flow

1. The source CSV provides customer acquisition data.
2. Python/Jupyter is used for the original exploratory CAC analysis.
3. Talend reads and validates the source data.
4. Valid records are loaded into the Snowflake RAW layer.
5. Invalid records are written to the rejected-record CSV.
6. Snowflake SQL transforms the data through the STAGING layer.
7. The ANALYTICS layer produces business-ready metrics.
8. Tableau consumes the analytical data and presents the results through an executive dashboard.

---

## Data Quality & Validation

Data quality checks are performed during the Talend ingestion process.

The pipeline validates:

* Required customer identifiers
* Supported marketing channels
* Valid marketing spend values
* Valid new customer counts

Rather than silently discarding invalid data, rejected records are written separately:

```text
data/rejects/customer_acquisition_cost_rejects.csv
```

This provides a basic level of **data traceability and error handling** within the ingestion workflow.

---

## Reproducibility

The repository contains the core components required to understand and reproduce the project workflow:

* Source datasets
* Python/Jupyter analysis
* Talend ETL job
* Talend schemas
* Snowflake SQL scripts
* Tableau workbook
* Dashboard screenshots
* Rejected-record output

### Credentials

No credentials or sensitive authentication information are stored in the repository.

Talend and Snowflake authentication must be supplied through the user's local configuration and execution environment.

---

## Project Evolution

The project demonstrates the progression from exploratory data analysis to a structured data engineering pipeline:

```text
Exploratory Analysis
        │
        ▼
Python + Pandas + Plotly
        │
        ▼
Data Ingestion & Validation
        │
        ▼
Talend ETL
        │
        ▼
Snowflake RAW
        │
        ▼
Snowflake STAGING
        │
        ▼
Snowflake ANALYTICS
        │
        ▼
Tableau Business Intelligence
```

---

## Key Skills Demonstrated

**Data Engineering**

* ETL pipeline development
* Data validation
* Error/reject handling
* Data ingestion
* Data warehouse layering

**Snowflake**

* RAW / STAGING / ANALYTICS architecture
* SQL transformations
* Analytical tables
* Snowflake tasks

**Data Analysis**

* Python
* Pandas
* Jupyter Notebook
* CAC analysis
* Statistical summaries

**Business Intelligence**

* Tableau
* KPI development
* Interactive dashboards
* Marketing-channel analysis

---

## Summary

This project demonstrates an end-to-end transition from exploratory analytics to a structured data engineering and business intelligence workflow:

**Data Analysis → Data Ingestion → Data Validation → ETL → Cloud Data Warehousing → SQL Transformation → Analytics → Business Intelligence**


