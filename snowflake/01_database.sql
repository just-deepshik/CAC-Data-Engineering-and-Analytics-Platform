-- ============================================================
-- CAC Analytics Platform
-- Snowflake Database Setup
-- ============================================================

CREATE DATABASE IF NOT EXISTS CAC_ANALYTICS;

USE DATABASE CAC_ANALYTICS;

CREATE SCHEMA IF NOT EXISTS RAW;

CREATE SCHEMA IF NOT EXISTS STAGING;

CREATE SCHEMA IF NOT EXISTS ANALYTICS;