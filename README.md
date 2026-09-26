# CAC Automation and Visualization Platform

An end-to-end data engineering and analytics project for automating **Customer Acquisition Cost (CAC)** analysis. The project takes raw customer acquisition data through an ETL pipeline, loads it into Snowflake, applies SQL-based transformations, and presents the resulting business metrics through an interactive Tableau executive dashboard.

## Project Overview

Customer Acquisition Cost (CAC) is a key marketing metric that measures the cost required to acquire new customers.

This project was developed as an evolution from a Python-based CAC analysis into a complete data engineering workflow:

**CSV Data → Talend ETL → Snowflake RAW → STAGING → ANALYTICS → Tableau**

The platform supports data ingestion, validation, transformation, analytical aggregation, and business visualization.

---

## Architecture

```text
                    SOURCE DATA
                        │
                        ▼
        customer_acquisition_cost_dataset.csv
                        │
                        ▼
                  TALEND ETL
              JOB_CAC_CSV_TO_SNOWFLAKE_RAW
                        │
              ┌─────────┴─────────┐
              │                   │
         Valid Records       Rejected Records
              │                   │
              ▼                   ▼
        SNOWFLAKE RAW        data/rejects/
              │
              ▼
        SNOWFLAKE STAGING
              │
              ▼
        SNOWFLAKE ANALYTICS
              │
              ▼
       TABLEAU EXECUTIVE
          DASHBOARD
