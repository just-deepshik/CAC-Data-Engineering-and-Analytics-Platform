-- ============================================================
-- CAC Analytics Platform
-- Snowflake RAW Layer
-- ============================================================

USE DATABASE CAC_ANALYTICS;

CREATE SCHEMA IF NOT EXISTS RAW;

CREATE TABLE IF NOT EXISTS CAC_ANALYTICS.RAW.CUSTOMER_ACQUISITION_RAW (
    CUSTOMER_ID        VARCHAR(50),
    MARKETING_CHANNEL  VARCHAR(100),
    MARKETING_SPEND    NUMBER(12,2),
    NEW_CUSTOMERS      NUMBER(10,0),
    SOURCE_FILE_NAME   VARCHAR(255),
    LOADED_AT          TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);