-- ============================================================
-- CAC Analytics Platform
-- Snowflake ANALYTICS Layer
-- ============================================================

USE DATABASE CAC_ANALYTICS;

CREATE SCHEMA IF NOT EXISTS ANALYTICS;


-- ============================================================
-- Customer-level analytical table
-- ============================================================

CREATE OR REPLACE TABLE CAC_ANALYTICS.ANALYTICS.CAC_CUSTOMER_ANALYTICS AS
SELECT
    CUSTOMER_ID,
    MARKETING_CHANNEL,
    MARKETING_SPEND,
    NEW_CUSTOMERS,
    SOURCE_FILE_NAME,
    LOADED_AT,

    ROUND(
        MARKETING_SPEND / NULLIF(NEW_CUSTOMERS, 0),
        2
    ) AS CAC,

    ROUND(
        (NEW_CUSTOMERS / NULLIF(MARKETING_SPEND, 0)) * 100,
        4
    ) AS CONVERSION_RATE

FROM CAC_ANALYTICS.STAGING.CUSTOMER_ACQUISITION_STG;


-- ============================================================
-- Channel-level analytical summary
-- ============================================================

CREATE OR REPLACE TABLE CAC_ANALYTICS.ANALYTICS.CAC_CHANNEL_SUMMARY AS
SELECT
    MARKETING_CHANNEL,
    COUNT(*) AS CUSTOMER_COUNT,
    SUM(MARKETING_SPEND) AS TOTAL_MARKETING_SPEND,
    SUM(NEW_CUSTOMERS) AS TOTAL_NEW_CUSTOMERS,
    ROUND(AVG(CAC), 2) AS AVERAGE_CAC,
    ROUND(
        SUM(MARKETING_SPEND) / NULLIF(SUM(NEW_CUSTOMERS), 0),
        2
    ) AS WEIGHTED_CAC,
    ROUND(AVG(CONVERSION_RATE), 4) AS AVERAGE_CONVERSION_RATE

FROM CAC_ANALYTICS.ANALYTICS.CAC_CUSTOMER_ANALYTICS

GROUP BY MARKETING_CHANNEL

ORDER BY MARKETING_CHANNEL;


-- ============================================================
-- Executive-level summary
-- ============================================================

CREATE OR REPLACE TABLE CAC_ANALYTICS.ANALYTICS.CAC_EXECUTIVE_SUMMARY AS
SELECT
    COUNT(*) AS TOTAL_CUSTOMERS,
    SUM(MARKETING_SPEND) AS TOTAL_MARKETING_SPEND,
    SUM(NEW_CUSTOMERS) AS TOTAL_NEW_CUSTOMERS,

    ROUND(
        SUM(MARKETING_SPEND) /
        NULLIF(SUM(NEW_CUSTOMERS), 0),
        2
    ) AS OVERALL_WEIGHTED_CAC,

    ROUND(AVG(CAC), 2) AS OVERALL_AVERAGE_CAC,

    ROUND(
        AVG(CONVERSION_RATE),
        4
    ) AS OVERALL_AVERAGE_CONVERSION_RATE,

    COUNT(DISTINCT MARKETING_CHANNEL) AS MARKETING_CHANNEL_COUNT

FROM CAC_ANALYTICS.ANALYTICS.CAC_CUSTOMER_ANALYTICS;