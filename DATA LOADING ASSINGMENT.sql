
   DATASET OVERVIEW
   Columns:
   Order_ID, Customer_ID, Sales_Amount, Order_Date



/* 
   Q1. DATA UNDERSTANDING
   Identify all data quality issues in the dataset.
   
   Issues Found:
   1. Duplicate Primary Key:
      - Order_ID 'O101' appears twice.
   
   2. Missing Value:
      - Sales_Amount is NULL for Order_ID 'O102'.
   
   3. Data Type Issue:
      - Sales_Amount = 'Three Thousand' (text instead of numeric)
        for Order_ID 'O104'.
   
   4. Date Format Inconsistency:
      - '12-01-2024' (DD-MM-YYYY)
      - '2024/01/18' (YYYY/MM/DD)
      - Mixed formats in Order_Date column.
   
   These issues can cause loading failures and incorrect analytics.
   */


/* 
   Q2. PRIMARY KEY VALIDATION
   Assume Order_ID is the Primary Key.
   
   a) Is dataset violating Primary Key rule?
      YES.
   
   b) Which records cause violation?
      Order_ID 'O101' appears twice:
      - Row 1
      - Row 4
   
   Duplicate primary keys will cause constraint violation
   during database loading.
 */


/* 
   Q3. MISSING VALUE ANALYSIS
   
   a) Column containing missing values:
      - Sales_Amount
   
   b) Affected Record:
      - Order_ID 'O102'
   
   c) Why loading without handling is risky?
      - Incorrect sales aggregation.
      - KPI miscalculation.
      - NULL propagation in reports.
   */


/*
   Q4. DATA TYPE VALIDATION
   
   a) Record violating numeric rule:
      - Order_ID 'O104'
      - Sales_Amount = 'Three Thousand'
   
   b) What happens if loaded as DECIMAL?
      - Load failure OR
      - Value converted to NULL OR
      - Numeric conversion error.
   
   This will break ETL process or corrupt financial data.
  */


/* 
   Q5. DATE FORMAT CONSISTENCY
   
   a) Date formats present:
      - DD-MM-YYYY  (12-01-2024)
      - YYYY/MM/DD  (2024/01/18)
   
   b) Why is this a problem?
      - Parsing errors during loading.
      - Incorrect date interpretation.
      - Sorting and filtering inconsistencies.
   
   Databases require standardized DATE format.
   */


/* 
   Q6. LOAD READINESS DECISION
   
   a) Should dataset be loaded directly?
      NO.
   
   b) Justification (at least three reasons):
      1. Duplicate Primary Key.
      2. Missing Sales_Amount value.
      3. Non-numeric Sales_Amount entry.
      4. Inconsistent Date formats.
   
   Dataset must be cleaned before loading.
    */


/* 
   Q7. PRE-LOAD VALIDATION CHECKLIST
   
   1. Check for duplicate primary keys.
   2. Validate numeric fields (Sales_Amount).
   3. Check for NULL values.
   4. Standardize date formats.
   5. Verify data type compatibility.
   6. Validate business rules (Sales_Amount > 0).
   7. Remove leading/trailing spaces.
  */


/* 
   Q8. CLEANING STRATEGY (STEP-BY-STEP)
   
   Step 1: Remove duplicate Order_ID (keep latest record).
   Step 2: Convert 'Three Thousand' to numeric (3000).
   Step 3: Handle NULL Sales_Amount:
           - Impute OR reject record.
   Step 4: Standardize all dates to YYYY-MM-DD format.
   Step 5: Validate numeric constraints.
   Step 6: Re-check primary key uniqueness.
   
   After these steps, dataset becomes load-ready.
 */


/* 
   Q9. LOADING STRATEGY SELECTION
   
   Assume dataset represents daily sales data.
   
   a) Use Incremental Load.
   
   b) Justification:
      - Daily sales data grows over time.
      - Only new records should be inserted.
      - Reduces processing time.
      - Improves performance.
  */


/* 
   Q10. BI IMPACT SCENARIO
   
   a) Incorrect results in Total Sales KPI:
      - Duplicate O101 will inflate total sales.
      - NULL sales will reduce totals.
      - Text value will be excluded from aggregation.
   
   b) Records causing misleading insights:
      - O101 (duplicate)
      - O102 (NULL)
      - O104 (text value)
   
   c) Why BI tools may not detect automatically:
      - BI tools assume data is clean.
      - They aggregate whatever is loaded.
      - No built-in validation unless rules are applied.
   
   This leads to inaccurate dashboards.
  */