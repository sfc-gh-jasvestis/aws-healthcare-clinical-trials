------------------------------------------------------------------------
-- Clinical Trial Operations: RAW Tables + Reference Data
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA RAW;

------------------------------------------------------------------------
-- TRIALS (50 rows)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE TRIALS (
    TRIAL_ID VARCHAR(20) PRIMARY KEY,
    TRIAL_NAME VARCHAR(200),
    PHASE VARCHAR(10),
    THERAPEUTIC_AREA VARCHAR(50),
    INDICATION VARCHAR(100),
    SPONSOR VARCHAR(100),
    STATUS VARCHAR(20),
    TARGET_ENROLLMENT INT,
    START_DATE DATE,
    EXPECTED_END_DATE DATE,
    PRIMARY_ENDPOINT VARCHAR(500),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO TRIALS VALUES
('CARDIO-PREVENT-301','Cardio Prevention Phase III','Phase III','Cardiovascular','Atherosclerosis','NovaPharm Global','ACTIVE',3400,'2024-06-01','2026-12-31','Reduction in MACE at 24 months',CURRENT_TIMESTAMP()),
('ONCO-LUNG-201','Lung Cancer Combo Therapy','Phase II','Oncology','NSCLC','BioGenesis Ltd','ACTIVE',800,'2024-09-15','2026-06-30','ORR per RECIST 1.1',CURRENT_TIMESTAMP()),
('NEURO-ALZ-102','Alzheimer Early Intervention','Phase I/II','Neurology','Alzheimer Disease','NeuroVita Inc','ACTIVE',200,'2025-01-10','2027-01-10','CSF biomarker change at 12 months',CURRENT_TIMESTAMP()),
('ENDO-DM2-301','Type 2 Diabetes GLP-1 Trial','Phase III','Endocrinology','Type 2 Diabetes','MetaHealth','ACTIVE',2200,'2024-08-01','2026-09-30','HbA1c reduction at 52 weeks',CURRENT_TIMESTAMP()),
('RESP-COPD-202','COPD Biologic Therapy','Phase II','Respiratory','COPD','AirWay Therapeutics','ACTIVE',600,'2024-11-01','2026-08-15','FEV1 improvement at 24 weeks',CURRENT_TIMESTAMP()),
('DERM-PSO-301','Psoriasis IL-17 Inhibitor','Phase III','Dermatology','Psoriasis','SkinClear Bio','ACTIVE',1500,'2024-07-15','2026-07-15','PASI 90 at 16 weeks',CURRENT_TIMESTAMP()),
('HEMA-CLL-201','CLL BTK Inhibitor Combo','Phase II','Hematology','CLL','HematoGen','ACTIVE',450,'2025-02-01','2027-02-01','CR rate at 12 months',CURRENT_TIMESTAMP()),
('CARDIO-HF-202','Heart Failure SGLT2 Extension','Phase II','Cardiovascular','Heart Failure','NovaPharm Global','ACTIVE',900,'2024-10-01','2026-10-01','NT-proBNP reduction at 6 months',CURRENT_TIMESTAMP()),
('ONCO-BREAST-301','Triple Negative Breast Cancer','Phase III','Oncology','TNBC','BioGenesis Ltd','ACTIVE',1800,'2024-05-01','2026-11-30','PFS per IRC',CURRENT_TIMESTAMP()),
('NEURO-MS-301','Multiple Sclerosis BTK','Phase III','Neurology','Multiple Sclerosis','NeuroVita Inc','ACTIVE',1200,'2024-04-01','2026-10-01','Annualized relapse rate',CURRENT_TIMESTAMP()),
('ENDO-NASH-201','NASH FXR Agonist','Phase II','Endocrinology','NASH','MetaHealth','ACTIVE',500,'2025-03-01','2027-03-01','Fibrosis improvement at 48 weeks',CURRENT_TIMESTAMP()),
('RESP-ASTH-301','Severe Asthma Anti-TSLP','Phase III','Respiratory','Severe Asthma','AirWay Therapeutics','ACTIVE',1600,'2024-06-15','2026-06-15','Annual exacerbation rate reduction',CURRENT_TIMESTAMP()),
('IMMUNO-RA-202','Rheumatoid Arthritis JAK','Phase II','Immunology','Rheumatoid Arthritis','ImmunoPath','ACTIVE',700,'2024-12-01','2026-12-01','ACR50 at 12 weeks',CURRENT_TIMESTAMP()),
('ONCO-CRC-201','Colorectal Cancer IO Combo','Phase II','Oncology','Colorectal Cancer','BioGenesis Ltd','ACTIVE',350,'2025-01-15','2027-01-15','ORR in MSS-CRC',CURRENT_TIMESTAMP()),
('CARDIO-AFib-201','Atrial Fibrillation Novel Anticoag','Phase II','Cardiovascular','Atrial Fibrillation','NovaPharm Global','ACTIVE',650,'2025-02-15','2027-02-15','Stroke/SE rate vs warfarin',CURRENT_TIMESTAMP()),
('NEURO-PD-101','Parkinson Disease Gene Therapy','Phase I','Neurology','Parkinson Disease','NeuroVita Inc','ACTIVE',60,'2025-04-01','2027-10-01','Safety and tolerability',CURRENT_TIMESTAMP()),
('HEMA-AML-301','AML FLT3 Inhibitor Maint','Phase III','Hematology','AML','HematoGen','ACTIVE',1100,'2024-08-15','2026-08-15','Relapse-free survival',CURRENT_TIMESTAMP()),
('DERM-AD-202','Atopic Dermatitis OX40','Phase II','Dermatology','Atopic Dermatitis','SkinClear Bio','ACTIVE',400,'2025-01-01','2026-12-31','EASI-75 at 16 weeks',CURRENT_TIMESTAMP()),
('ENDO-OBS-301','Obesity GIP/GLP-1 Dual','Phase III','Endocrinology','Obesity','MetaHealth','ACTIVE',2800,'2024-07-01','2026-12-01','Percent body weight loss at 68 weeks',CURRENT_TIMESTAMP()),
('RESP-IPF-201','IPF Antifibrotic Combo','Phase II','Respiratory','IPF','AirWay Therapeutics','ACTIVE',300,'2025-03-15','2027-03-15','FVC decline at 52 weeks',CURRENT_TIMESTAMP()),
('ONCO-PROST-301','Prostate Cancer PARP+AR','Phase III','Oncology','Prostate Cancer','BioGenesis Ltd','ACTIVE',1400,'2024-09-01','2026-09-01','rPFS in HRR-mutated',CURRENT_TIMESTAMP()),
('IMMUNO-SLE-201','Lupus Anti-BLyS/APRIL','Phase II','Immunology','SLE','ImmunoPath','ACTIVE',550,'2025-02-01','2027-02-01','SRI-4 response at 52 weeks',CURRENT_TIMESTAMP()),
('CARDIO-PAH-301','Pulmonary Hypertension Combo','Phase III','Cardiovascular','PAH','NovaPharm Global','ACTIVE',850,'2024-11-15','2026-11-15','6MWD improvement at 16 weeks',CURRENT_TIMESTAMP()),
('NEURO-EPI-301','Epilepsy Novel ASM','Phase III','Neurology','Epilepsy','NeuroVita Inc','ACTIVE',950,'2024-10-15','2026-10-15','Seizure frequency reduction',CURRENT_TIMESTAMP()),
('HEMA-MDS-201','MDS Hypomethylating Agent','Phase II','Hematology','MDS','HematoGen','ACTIVE',280,'2025-04-01','2027-04-01','Transfusion independence at 24 weeks',CURRENT_TIMESTAMP()),
('ONCO-MELANOMA-201','Melanoma LAG3+PD1','Phase II','Oncology','Melanoma','BioGenesis Ltd','ACTIVE',500,'2025-01-01','2026-12-31','ORR in anti-PD1 refractory',CURRENT_TIMESTAMP()),
('DERM-VIT-201','Vitiligo JAK Topical','Phase II','Dermatology','Vitiligo','SkinClear Bio','ACTIVE',350,'2025-03-01','2027-03-01','F-VASI50 at 24 weeks',CURRENT_TIMESTAMP()),
('ENDO-HYPO-301','Hypoparathyroidism PTH','Phase III','Endocrinology','Hypoparathyroidism','MetaHealth','ACTIVE',250,'2025-02-15','2027-02-15','Calcium normalization without supplements',CURRENT_TIMESTAMP()),
('RESP-BRON-201','Bronchiectasis Anti-NE','Phase II','Respiratory','Bronchiectasis','AirWay Therapeutics','ACTIVE',400,'2025-04-15','2027-04-15','Pulmonary exacerbation rate',CURRENT_TIMESTAMP()),
('IMMUNO-AS-301','Ankylosing Spondylitis IL-17A','Phase III','Immunology','Ankylosing Spondylitis','ImmunoPath','ACTIVE',750,'2024-12-15','2026-12-15','ASAS40 at 16 weeks',CURRENT_TIMESTAMP()),
('ONCO-HCC-201','Hepatocellular Carcinoma Combo','Phase II','Oncology','HCC','BioGenesis Ltd','ACTIVE',420,'2025-03-01','2027-03-01','ORR per mRECIST',CURRENT_TIMESTAMP()),
('CARDIO-CAD-202','Coronary Artery Disease Anti-inflam','Phase II','Cardiovascular','CAD','NovaPharm Global','ACTIVE',500,'2025-01-15','2027-01-15','hsCRP reduction at 12 months',CURRENT_TIMESTAMP()),
('NEURO-MIG-301','Chronic Migraine CGRP','Phase III','Neurology','Migraine','NeuroVita Inc','ACTIVE',1300,'2024-08-01','2026-08-01','Monthly migraine days reduction',CURRENT_TIMESTAMP()),
('HEMA-ITP-201','ITP SYK Inhibitor','Phase II','Hematology','ITP','HematoGen','ACTIVE',200,'2025-05-01','2027-05-01','Platelet response at 24 weeks',CURRENT_TIMESTAMP()),
('DERM-HSP-201','Hidradenitis Suppurativa IL-36','Phase II','Dermatology','Hidradenitis','SkinClear Bio','ACTIVE',320,'2025-04-01','2027-04-01','HiSCR at 16 weeks',CURRENT_TIMESTAMP()),
('ENDO-ACRO-201','Acromegaly Oral Somatostatin','Phase II','Endocrinology','Acromegaly','MetaHealth','ACTIVE',180,'2025-05-01','2027-05-01','IGF-1 normalization',CURRENT_TIMESTAMP()),
('IMMUNO-UC-301','Ulcerative Colitis S1P','Phase III','Immunology','Ulcerative Colitis','ImmunoPath','ACTIVE',1100,'2024-09-15','2026-09-15','Clinical remission at 52 weeks',CURRENT_TIMESTAMP()),
('ONCO-PANC-201','Pancreatic Cancer Stromal','Phase II','Oncology','Pancreatic Cancer','BioGenesis Ltd','ACTIVE',250,'2025-04-15','2027-04-15','OS in first-line',CURRENT_TIMESTAMP()),
('RESP-RSV-301','RSV Monoclonal Prophylaxis','Phase III','Respiratory','RSV','AirWay Therapeutics','ACTIVE',3000,'2024-06-01','2026-06-01','RSV-LRTI hospitalization',CURRENT_TIMESTAMP()),
('NEURO-ALS-201','ALS Antisense Oligonucleotide','Phase II','Neurology','ALS','NeuroVita Inc','ACTIVE',150,'2025-06-01','2027-12-01','ALSFRS-R slope change',CURRENT_TIMESTAMP()),
('CARDIO-DVT-301','VTE Direct Oral Anticoag','Phase III','Cardiovascular','VTE','NovaPharm Global','ACTIVE',2000,'2024-07-01','2026-07-01','Recurrent VTE at 12 months',CURRENT_TIMESTAMP()),
('HEMA-NHL-301','NHL Bispecific Antibody','Phase III','Hematology','NHL','HematoGen','ACTIVE',1000,'2024-10-01','2026-10-01','CR rate at 12 months',CURRENT_TIMESTAMP()),
('ONCO-OVARIAN-201','Ovarian Cancer PARP Combo','Phase II','Oncology','Ovarian Cancer','BioGenesis Ltd','ACTIVE',380,'2025-02-01','2027-02-01','PFS in BRCA-mutated',CURRENT_TIMESTAMP()),
('IMMUNO-CD-301','Crohn Disease IL-23','Phase III','Immunology','Crohn Disease','ImmunoPath','ACTIVE',1400,'2024-11-01','2026-11-01','Clinical remission at 52 weeks',CURRENT_TIMESTAMP()),
('DERM-ALOPECIA-301','Alopecia Areata JAK','Phase III','Dermatology','Alopecia Areata','SkinClear Bio','ACTIVE',900,'2024-12-01','2026-12-01','SALT30 at 36 weeks',CURRENT_TIMESTAMP()),
('ENDO-T1D-201','Type 1 Diabetes Teplizumab','Phase II','Endocrinology','Type 1 Diabetes','MetaHealth','ACTIVE',300,'2025-05-15','2027-11-15','C-peptide preservation at 78 weeks',CURRENT_TIMESTAMP()),
('RESP-CF-301','Cystic Fibrosis Triple Combo','Phase III','Respiratory','Cystic Fibrosis','AirWay Therapeutics','ACTIVE',800,'2024-09-01','2026-09-01','ppFEV1 improvement at 24 weeks',CURRENT_TIMESTAMP()),
('NEURO-DEPR-301','Treatment Resistant Depression','Phase III','Neurology','Depression','NeuroVita Inc','ACTIVE',1500,'2024-08-15','2026-08-15','MADRS change at 6 weeks',CURRENT_TIMESTAMP()),
('ONCO-GLIO-101','Glioblastoma CAR-T','Phase I','Oncology','Glioblastoma','BioGenesis Ltd','ACTIVE',45,'2025-06-01','2027-12-01','Safety and MTD',CURRENT_TIMESTAMP()),
('IMMUNO-PSA-301','Psoriatic Arthritis IL-17A/F','Phase III','Immunology','Psoriatic Arthritis','ImmunoPath','ACTIVE',800,'2024-11-15','2026-11-15','ACR50 + PASI100 at 24 weeks',CURRENT_TIMESTAMP());

------------------------------------------------------------------------
-- SITES (15 rows - APJ hospitals with real coordinates)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE SITES (
    SITE_ID VARCHAR(10) PRIMARY KEY,
    SITE_NAME VARCHAR(200),
    HOSPITAL_NAME VARCHAR(200),
    CITY VARCHAR(50),
    COUNTRY VARCHAR(50),
    REGION VARCHAR(20),
    LATITUDE FLOAT,
    LONGITUDE FLOAT,
    PI_NAME VARCHAR(100),
    BEDS INT,
    ACTIVE_TRIALS INT,
    STATUS VARCHAR(20),
    ACTIVATED_DATE DATE,
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO SITES VALUES
('SITE-001','SGH Clinical Research','Singapore General Hospital','Singapore','Singapore','APJ',1.2789,103.8353,'Dr. Tan Wei Ming',1785,12,'ACTIVE','2024-06-01',CURRENT_TIMESTAMP()),
('SITE-002','NUH Research Centre','National University Hospital','Singapore','Singapore','APJ',1.2937,103.7831,'Dr. Lim Siew Kee',1200,10,'ACTIVE','2024-06-01',CURRENT_TIMESTAMP()),
('SITE-003','TTSH Clinical Trials','Tan Tock Seng Hospital','Singapore','Singapore','APJ',1.3215,103.8458,'Dr. Wong Chee Kin',1600,8,'ACTIVE','2024-07-15',CURRENT_TIMESTAMP()),
('SITE-004','RPA Research Institute','Royal Prince Alfred Hospital','Sydney','Australia','APJ',-33.8891,151.1810,'Dr. Sarah Mitchell',900,9,'ACTIVE','2024-06-15',CURRENT_TIMESTAMP()),
('SITE-005','Tokyo Medical Research','Tokyo Medical University Hospital','Tokyo','Japan','APJ',35.6936,139.7200,'Dr. Takeshi Yamamoto',1100,11,'ACTIVE','2024-06-01',CURRENT_TIMESTAMP()),
('SITE-006','Bumrungrad Research','Bumrungrad International Hospital','Bangkok','Thailand','APJ',13.7465,100.5514,'Dr. Somchai Patel',580,7,'ACTIVE','2024-08-01',CURRENT_TIMESTAMP()),
('SITE-007','AIIMS Delhi Trials','All India Institute of Medical Sciences','New Delhi','India','APJ',28.5672,77.2100,'Dr. Rajesh Kumar',2478,14,'ACTIVE','2024-06-01',CURRENT_TIMESTAMP()),
('SITE-008','Seoul National Research','Seoul National University Hospital','Seoul','South Korea','APJ',37.5796,126.9990,'Dr. Kim Jae-Won',1786,10,'ACTIVE','2024-07-01',CURRENT_TIMESTAMP()),
('SITE-009','Queen Mary Research','Queen Mary Hospital','Hong Kong','Hong Kong','APJ',22.2704,114.1314,'Dr. Chan Wai Lam',1400,8,'ACTIVE','2024-08-15',CURRENT_TIMESTAMP()),
('SITE-010','Melbourne Royal','Royal Melbourne Hospital','Melbourne','Australia','APJ',-37.7993,144.9557,'Dr. James Patterson',800,6,'ACTIVE','2024-09-01',CURRENT_TIMESTAMP()),
('SITE-011','Osaka Medical Centre','Osaka University Hospital','Osaka','Japan','APJ',34.8230,135.5230,'Dr. Kenji Tanaka',1086,9,'ACTIVE','2024-07-15',CURRENT_TIMESTAMP()),
('SITE-012','Apollo Research','Apollo Hospitals','Chennai','India','APJ',13.0106,80.2269,'Dr. Priya Sharma',710,8,'ACTIVE','2024-09-15',CURRENT_TIMESTAMP()),
('SITE-013','Asan Medical Research','Asan Medical Center','Seoul','South Korea','APJ',37.5267,127.1081,'Dr. Park Min-Soo',2700,12,'ACTIVE','2024-06-15',CURRENT_TIMESTAMP()),
('SITE-014','NCCS Research','National Cancer Centre Singapore','Singapore','Singapore','APJ',1.2741,103.8408,'Dr. Lee Kah Yee',500,6,'ACTIVE','2024-10-01',CURRENT_TIMESTAMP()),
('SITE-015','Peking Union Research','Peking Union Medical College Hospital','Beijing','China','APJ',39.9091,116.4170,'Dr. Zhang Wei',2000,11,'ACTIVE','2024-07-01',CURRENT_TIMESTAMP());

------------------------------------------------------------------------
-- PATIENTS (10,000 rows - APJ names via GENERATOR)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE PATIENTS (
    PATIENT_ID VARCHAR(15) PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    DATE_OF_BIRTH DATE,
    GENDER VARCHAR(10),
    ETHNICITY VARCHAR(30),
    COUNTRY VARCHAR(50),
    SITE_ID VARCHAR(10),
    BMI FLOAT,
    SMOKING_STATUS VARCHAR(20),
    DIABETES_STATUS VARCHAR(20),
    HYPERTENSION VARCHAR(5),
    CHOLESTEROL_LEVEL FLOAT,
    CHRONIC_CONDITIONS VARCHAR(200),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO PATIENTS
(PATIENT_ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, GENDER, ETHNICITY, COUNTRY, SITE_ID, BMI, SMOKING_STATUS, DIABETES_STATUS, HYPERTENSION, CHOLESTEROL_LEVEL, CHRONIC_CONDITIONS)
WITH BASE AS (
    SELECT
        SEQ4() AS RN,
        CASE UNIFORM(0, 7, RANDOM())
            WHEN 0 THEN 'Singapore' WHEN 1 THEN 'Singapore' WHEN 2 THEN 'Japan'
            WHEN 3 THEN 'India' WHEN 4 THEN 'South Korea' WHEN 5 THEN 'Thailand'
            WHEN 6 THEN 'Australia' WHEN 7 THEN 'China'
        END AS COUNTRY,
        CASE WHEN UNIFORM(0, 1, RANDOM()) = 0 THEN 'Male' ELSE 'Female' END AS GENDER
    FROM TABLE(GENERATOR(ROWCOUNT => 10000))
)
SELECT
    'PAT-' || LPAD(RN::VARCHAR, 5, '0'),
    CASE
        WHEN COUNTRY = 'Singapore' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Wei' WHEN 1 THEN 'Jun' WHEN 2 THEN 'Liang' WHEN 3 THEN 'Zhi' WHEN 4 THEN 'Ahmad' WHEN 5 THEN 'Hao' WHEN 6 THEN 'Rajan' WHEN 7 THEN 'Kai' WHEN 8 THEN 'Zheng' WHEN 9 THEN 'Hafiz' WHEN 10 THEN 'Boon' WHEN 11 THEN 'Cheng' WHEN 12 THEN 'Ismail' WHEN 13 THEN 'Kian' ELSE 'Teck' END
        WHEN COUNTRY = 'Singapore' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Mei' WHEN 1 THEN 'Hui' WHEN 2 THEN 'Siti' WHEN 3 THEN 'Yan' WHEN 4 THEN 'Nurul' WHEN 5 THEN 'Ling' WHEN 6 THEN 'Fang' WHEN 7 THEN 'Xin' WHEN 8 THEN 'Ai' WHEN 9 THEN 'Fatimah' WHEN 10 THEN 'Jing' WHEN 11 THEN 'Li Hua' WHEN 12 THEN 'Aminah' WHEN 13 THEN 'Sze' ELSE 'Pei' END
        WHEN COUNTRY = 'Japan' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Kenji' WHEN 1 THEN 'Hiroshi' WHEN 2 THEN 'Takeshi' WHEN 3 THEN 'Kenta' WHEN 4 THEN 'Ren' WHEN 5 THEN 'Daiki' WHEN 6 THEN 'Yuto' WHEN 7 THEN 'Haruki' WHEN 8 THEN 'Sota' WHEN 9 THEN 'Riku' WHEN 10 THEN 'Kaito' WHEN 11 THEN 'Shota' WHEN 12 THEN 'Hayato' WHEN 13 THEN 'Ryota' ELSE 'Tatsuki' END
        WHEN COUNTRY = 'Japan' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Yuki' WHEN 1 THEN 'Sakura' WHEN 2 THEN 'Aiko' WHEN 3 THEN 'Yumi' WHEN 4 THEN 'Hana' WHEN 5 THEN 'Miku' WHEN 6 THEN 'Rin' WHEN 7 THEN 'Mei' WHEN 8 THEN 'Akari' WHEN 9 THEN 'Nanami' WHEN 10 THEN 'Koharu' WHEN 11 THEN 'Himari' WHEN 12 THEN 'Yuna' WHEN 13 THEN 'Saki' ELSE 'Misaki' END
        WHEN COUNTRY = 'India' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Raj' WHEN 1 THEN 'Vikram' WHEN 2 THEN 'Arjun' WHEN 3 THEN 'Deepak' WHEN 4 THEN 'Ravi' WHEN 5 THEN 'Suresh' WHEN 6 THEN 'Amit' WHEN 7 THEN 'Rahul' WHEN 8 THEN 'Sanjay' WHEN 9 THEN 'Nikhil' WHEN 10 THEN 'Pranav' WHEN 11 THEN 'Aditya' WHEN 12 THEN 'Karthik' WHEN 13 THEN 'Manoj' ELSE 'Venkat' END
        WHEN COUNTRY = 'India' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Priya' WHEN 1 THEN 'Ananya' WHEN 2 THEN 'Aisha' WHEN 3 THEN 'Neha' WHEN 4 THEN 'Kavitha' WHEN 5 THEN 'Lakshmi' WHEN 6 THEN 'Divya' WHEN 7 THEN 'Sneha' WHEN 8 THEN 'Pooja' WHEN 9 THEN 'Meera' WHEN 10 THEN 'Shruti' WHEN 11 THEN 'Isha' WHEN 12 THEN 'Tanvi' WHEN 13 THEN 'Anjali' ELSE 'Swathi' END
        WHEN COUNTRY = 'South Korea' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Min-Jun' WHEN 1 THEN 'Jae' WHEN 2 THEN 'Hyun' WHEN 3 THEN 'Dong' WHEN 4 THEN 'Seung' WHEN 5 THEN 'Tae' WHEN 6 THEN 'Jun-Ho' WHEN 7 THEN 'Sung' WHEN 8 THEN 'Woo-Jin' WHEN 9 THEN 'Joon' WHEN 10 THEN 'Kyung' WHEN 11 THEN 'Chang' WHEN 12 THEN 'Dae' WHEN 13 THEN 'Byung' ELSE 'Yong' END
        WHEN COUNTRY = 'South Korea' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Soo-Jin' WHEN 1 THEN 'Eun' WHEN 2 THEN 'Ji-Yeon' WHEN 3 THEN 'Yoon' WHEN 4 THEN 'Hye' WHEN 5 THEN 'Min-Seo' WHEN 6 THEN 'Da-Eun' WHEN 7 THEN 'Ha-Na' WHEN 8 THEN 'Su-Bin' WHEN 9 THEN 'Ye-Jin' WHEN 10 THEN 'Seo-Yeon' WHEN 11 THEN 'Chae' WHEN 12 THEN 'Bo-Ram' WHEN 13 THEN 'Ga-Eun' ELSE 'Nari' END
        WHEN COUNTRY = 'Thailand' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Somchai' WHEN 1 THEN 'Chai' WHEN 2 THEN 'Anan' WHEN 3 THEN 'Boon' WHEN 4 THEN 'Nattapong' WHEN 5 THEN 'Prasit' WHEN 6 THEN 'Wichai' WHEN 7 THEN 'Krit' WHEN 8 THEN 'Tanawat' WHEN 9 THEN 'Panya' WHEN 10 THEN 'Sukit' WHEN 11 THEN 'Thana' WHEN 12 THEN 'Anon' WHEN 13 THEN 'Prawit' ELSE 'Viroj' END
        WHEN COUNTRY = 'Thailand' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Lalita' WHEN 1 THEN 'Noor' WHEN 2 THEN 'Pim' WHEN 3 THEN 'Siri' WHEN 4 THEN 'Kanya' WHEN 5 THEN 'Mali' WHEN 6 THEN 'Ploy' WHEN 7 THEN 'Nipa' WHEN 8 THEN 'Araya' WHEN 9 THEN 'Chompoo' WHEN 10 THEN 'Dao' WHEN 11 THEN 'Kaew' WHEN 12 THEN 'Malee' WHEN 13 THEN 'Rung' ELSE 'Wanna' END
        WHEN COUNTRY = 'Australia' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'James' WHEN 1 THEN 'Liam' WHEN 2 THEN 'Jack' WHEN 3 THEN 'Noah' WHEN 4 THEN 'Ethan' WHEN 5 THEN 'Oliver' WHEN 6 THEN 'William' WHEN 7 THEN 'Thomas' WHEN 8 THEN 'Henry' WHEN 9 THEN 'Lucas' WHEN 10 THEN 'Alexander' WHEN 11 THEN 'Daniel' WHEN 12 THEN 'Samuel' WHEN 13 THEN 'Benjamin' ELSE 'Ryan' END
        WHEN COUNTRY = 'Australia' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Sarah' WHEN 1 THEN 'Emma' WHEN 2 THEN 'Olivia' WHEN 3 THEN 'Chloe' WHEN 4 THEN 'Mia' WHEN 5 THEN 'Charlotte' WHEN 6 THEN 'Amelia' WHEN 7 THEN 'Sophie' WHEN 8 THEN 'Grace' WHEN 9 THEN 'Isla' WHEN 10 THEN 'Ava' WHEN 11 THEN 'Harper' WHEN 12 THEN 'Lily' WHEN 13 THEN 'Ella' ELSE 'Ruby' END
        WHEN COUNTRY = 'China' AND GENDER = 'Male' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Wei' WHEN 1 THEN 'Jin' WHEN 2 THEN 'Dong' WHEN 3 THEN 'Chao' WHEN 4 THEN 'Ming' WHEN 5 THEN 'Hao' WHEN 6 THEN 'Tao' WHEN 7 THEN 'Lei' WHEN 8 THEN 'Peng' WHEN 9 THEN 'Bo' WHEN 10 THEN 'Feng' WHEN 11 THEN 'Long' WHEN 12 THEN 'Jian' WHEN 13 THEN 'Xiang' ELSE 'Yong' END
        WHEN COUNTRY = 'China' AND GENDER = 'Female' THEN
            CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Mei-Ling' WHEN 1 THEN 'Xiao' WHEN 2 THEN 'Lien' WHEN 3 THEN 'Fang' WHEN 4 THEN 'Hua' WHEN 5 THEN 'Li-Na' WHEN 6 THEN 'Yan' WHEN 7 THEN 'Jing' WHEN 8 THEN 'Xue' WHEN 9 THEN 'Ying' WHEN 10 THEN 'Lan' WHEN 11 THEN 'Qing' WHEN 12 THEN 'Rui' WHEN 13 THEN 'Shan' ELSE 'Ting' END
    END,
    CASE COUNTRY
        WHEN 'Singapore' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Tan' WHEN 1 THEN 'Lim' WHEN 2 THEN 'Lee' WHEN 3 THEN 'Wong' WHEN 4 THEN 'Chen' WHEN 5 THEN 'Ng' WHEN 6 THEN 'Ibrahim' WHEN 7 THEN 'Raj' WHEN 8 THEN 'Goh' WHEN 9 THEN 'Chua' WHEN 10 THEN 'Ong' WHEN 11 THEN 'Koh' WHEN 12 THEN 'Teo' WHEN 13 THEN 'Yeo' ELSE 'Ho' END
        WHEN 'Japan' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Yamamoto' WHEN 1 THEN 'Suzuki' WHEN 2 THEN 'Tanaka' WHEN 3 THEN 'Sato' WHEN 4 THEN 'Watanabe' WHEN 5 THEN 'Ito' WHEN 6 THEN 'Takahashi' WHEN 7 THEN 'Nakamura' WHEN 8 THEN 'Kobayashi' WHEN 9 THEN 'Saito' WHEN 10 THEN 'Kato' WHEN 11 THEN 'Yoshida' WHEN 12 THEN 'Yamada' WHEN 13 THEN 'Matsumoto' ELSE 'Inoue' END
        WHEN 'India' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Kumar' WHEN 1 THEN 'Sharma' WHEN 2 THEN 'Patel' WHEN 3 THEN 'Singh' WHEN 4 THEN 'Gupta' WHEN 5 THEN 'Reddy' WHEN 6 THEN 'Nair' WHEN 7 THEN 'Verma' WHEN 8 THEN 'Joshi' WHEN 9 THEN 'Iyer' WHEN 10 THEN 'Menon' WHEN 11 THEN 'Rao' WHEN 12 THEN 'Das' WHEN 13 THEN 'Pillai' ELSE 'Chatterjee' END
        WHEN 'South Korea' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Kim' WHEN 1 THEN 'Park' WHEN 2 THEN 'Lee' WHEN 3 THEN 'Choi' WHEN 4 THEN 'Jung' WHEN 5 THEN 'Kang' WHEN 6 THEN 'Yoon' WHEN 7 THEN 'Han' WHEN 8 THEN 'Lim' WHEN 9 THEN 'Shin' WHEN 10 THEN 'Oh' WHEN 11 THEN 'Seo' WHEN 12 THEN 'Kwon' WHEN 13 THEN 'Hwang' ELSE 'Ahn' END
        WHEN 'Thailand' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Srisai' WHEN 1 THEN 'Thongkham' WHEN 2 THEN 'Chaiyasit' WHEN 3 THEN 'Wongsawat' WHEN 4 THEN 'Phanit' WHEN 5 THEN 'Rattana' WHEN 6 THEN 'Siriwong' WHEN 7 THEN 'Prasert' WHEN 8 THEN 'Boonmee' WHEN 9 THEN 'Saetang' WHEN 10 THEN 'Jaidee' WHEN 11 THEN 'Kongtip' WHEN 12 THEN 'Somboon' WHEN 13 THEN 'Pongsakul' ELSE 'Maneerat' END
        WHEN 'Australia' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Mitchell' WHEN 1 THEN 'Patterson' WHEN 2 THEN 'Smith' WHEN 3 THEN 'Williams' WHEN 4 THEN 'Brown' WHEN 5 THEN 'Jones' WHEN 6 THEN 'Wilson' WHEN 7 THEN 'Taylor' WHEN 8 THEN 'Anderson' WHEN 9 THEN 'Thomas' WHEN 10 THEN 'Jackson' WHEN 11 THEN 'White' WHEN 12 THEN 'Harris' WHEN 13 THEN 'Martin' ELSE 'Thompson' END
        WHEN 'China' THEN CASE UNIFORM(0, 14, RANDOM()) WHEN 0 THEN 'Zhang' WHEN 1 THEN 'Wang' WHEN 2 THEN 'Li' WHEN 3 THEN 'Chen' WHEN 4 THEN 'Liu' WHEN 5 THEN 'Yang' WHEN 6 THEN 'Huang' WHEN 7 THEN 'Zhou' WHEN 8 THEN 'Wu' WHEN 9 THEN 'Xu' WHEN 10 THEN 'Sun' WHEN 11 THEN 'Ma' WHEN 12 THEN 'Zhu' WHEN 13 THEN 'Hu' ELSE 'Guo' END
    END,
    DATEADD('day', -UNIFORM(18*365, 85*365, RANDOM()), CURRENT_DATE()),
    GENDER,
    CASE COUNTRY
        WHEN 'Singapore' THEN CASE UNIFORM(0, 2, RANDOM()) WHEN 0 THEN 'Chinese' WHEN 1 THEN 'Malay' ELSE 'Indian' END
        WHEN 'Japan' THEN 'Japanese'
        WHEN 'India' THEN 'Indian'
        WHEN 'South Korea' THEN 'Korean'
        WHEN 'Thailand' THEN 'Thai'
        WHEN 'Australia' THEN CASE UNIFORM(0, 2, RANDOM()) WHEN 0 THEN 'Caucasian' WHEN 1 THEN 'Chinese' ELSE 'Indian' END
        WHEN 'China' THEN 'Chinese'
    END,
    COUNTRY,
    'SITE-' || LPAD((MOD(RN, 15) + 1)::VARCHAR, 3, '0'),
    ROUND(UNIFORM(18.0, 42.0, RANDOM())::FLOAT, 1),
    CASE UNIFORM(0, 4, RANDOM()) WHEN 0 THEN 'Never' WHEN 1 THEN 'Former' WHEN 2 THEN 'Current' WHEN 3 THEN 'Never' ELSE 'Never' END,
    CASE UNIFORM(0, 5, RANDOM()) WHEN 0 THEN 'None' WHEN 1 THEN 'Pre-diabetic' WHEN 2 THEN 'Type 2' WHEN 3 THEN 'None' WHEN 4 THEN 'None' ELSE 'Type 1' END,
    CASE WHEN UNIFORM(0, 3, RANDOM()) = 0 THEN 'Yes' ELSE 'No' END,
    ROUND(UNIFORM(120.0, 320.0, RANDOM())::FLOAT, 0),
    CASE UNIFORM(0, 19, RANDOM())
        WHEN 0 THEN 'Atrial Fibrillation'
        WHEN 1 THEN 'Atrial Fibrillation, Hypertension'
        WHEN 2 THEN 'Type 2 Diabetes'
        WHEN 3 THEN 'Type 2 Diabetes, Hypertension'
        WHEN 4 THEN 'COPD'
        WHEN 5 THEN 'Asthma'
        WHEN 6 THEN 'Heart Failure'
        WHEN 7 THEN 'Heart Failure, Atrial Fibrillation'
        WHEN 8 THEN 'Obesity'
        WHEN 9 THEN 'Obesity, Type 2 Diabetes'
        WHEN 10 THEN 'Rheumatoid Arthritis'
        WHEN 11 THEN 'Psoriasis'
        WHEN 12 THEN 'Cancer History'
        WHEN 13 THEN 'Alzheimer Disease'
        WHEN 14 THEN 'Multiple Sclerosis'
        WHEN 15 THEN 'Chronic Kidney Disease'
        WHEN 16 THEN 'Anticoagulation Therapy'
        WHEN 17 THEN 'None'
        WHEN 18 THEN 'None'
        WHEN 19 THEN 'Hypertension'
    END
FROM BASE;

------------------------------------------------------------------------
-- ENROLLMENTS (5,000 rows - skewed toward CARDIO-PREVENT-301)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE ENROLLMENTS (
    ENROLLMENT_ID VARCHAR(15) PRIMARY KEY,
    PATIENT_ID VARCHAR(15),
    TRIAL_ID VARCHAR(20),
    SITE_ID VARCHAR(10),
    ENROLLMENT_DATE DATE,
    STATUS VARCHAR(20),
    RANDOMIZATION_ARM VARCHAR(20),
    SCREEN_DATE DATE,
    SCREEN_RESULT VARCHAR(20),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO ENROLLMENTS
SELECT
    'ENR-' || LPAD(SEQ4()::VARCHAR, 5, '0'),
    'PAT-' || LPAD(UNIFORM(0, 9999, RANDOM())::VARCHAR, 5, '0'),
    CASE
        WHEN SEQ4() < 1054 THEN 'CARDIO-PREVENT-301'
        WHEN SEQ4() < 1354 THEN 'ONCO-BREAST-301'
        WHEN SEQ4() < 1604 THEN 'ENDO-OBS-301'
        WHEN SEQ4() < 1804 THEN 'NEURO-MS-301'
        WHEN SEQ4() < 1954 THEN 'RESP-ASTH-301'
        WHEN SEQ4() < 2104 THEN 'DERM-PSO-301'
        WHEN SEQ4() < 2254 THEN 'IMMUNO-CD-301'
        WHEN SEQ4() < 2404 THEN 'CARDIO-DVT-301'
        WHEN SEQ4() < 2554 THEN 'RESP-RSV-301'
        WHEN SEQ4() < 2704 THEN 'ENDO-DM2-301'
        WHEN SEQ4() < 2854 THEN 'ONCO-PROST-301'
        WHEN SEQ4() < 3004 THEN 'HEMA-AML-301'
        WHEN SEQ4() < 3154 THEN 'NEURO-DEPR-301'
        WHEN SEQ4() < 3304 THEN 'IMMUNO-UC-301'
        WHEN SEQ4() < 3454 THEN 'HEMA-NHL-301'
        WHEN SEQ4() < 3604 THEN 'DERM-ALOPECIA-301'
        WHEN SEQ4() < 3754 THEN 'NEURO-EPI-301'
        WHEN SEQ4() < 3904 THEN 'IMMUNO-AS-301'
        WHEN SEQ4() < 4054 THEN 'RESP-CF-301'
        WHEN SEQ4() < 4204 THEN 'CARDIO-PAH-301'
        WHEN SEQ4() < 4354 THEN 'ONCO-LUNG-201'
        WHEN SEQ4() < 4504 THEN 'IMMUNO-PSA-301'
        WHEN SEQ4() < 4604 THEN 'CARDIO-HF-202'
        WHEN SEQ4() < 4704 THEN 'IMMUNO-RA-202'
        WHEN SEQ4() < 4804 THEN 'ENDO-NASH-201'
        WHEN SEQ4() < 4904 THEN 'RESP-COPD-202'
        ELSE 'ONCO-CRC-201'
    END,
    'SITE-' || LPAD((MOD(SEQ4(), 15) + 1)::VARCHAR, 3, '0'),
    DATEADD('day', UNIFORM(0, 600, RANDOM()), '2024-06-01'::DATE),
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 'SCREEN_FAILED' WHEN 1 THEN 'SCREEN_FAILED'
        WHEN 2 THEN 'WITHDRAWN' WHEN 3 THEN 'COMPLETED'
        ELSE 'ENROLLED'
    END,
    CASE MOD(SEQ4(), 3)
        WHEN 0 THEN 'Treatment' WHEN 1 THEN 'Treatment' WHEN 2 THEN 'Placebo'
    END,
    DATEADD('day', -UNIFORM(7, 30, RANDOM()), DATEADD('day', UNIFORM(0, 600, RANDOM()), '2024-06-01'::DATE)),
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 'FAILED' WHEN 1 THEN 'FAILED' ELSE 'PASSED'
    END,
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 5000));

------------------------------------------------------------------------
-- VISITS (20,000 rows)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE VISITS (
    VISIT_ID VARCHAR(15) PRIMARY KEY,
    ENROLLMENT_ID VARCHAR(15),
    VISIT_TYPE VARCHAR(30),
    SCHEDULED_DATE DATE,
    ACTUAL_DATE DATE,
    STATUS VARCHAR(20),
    NOTES VARCHAR(500),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO VISITS
SELECT
    'VIS-' || LPAD(SEQ4()::VARCHAR, 6, '0'),
    'ENR-' || LPAD(UNIFORM(0, 4999, RANDOM())::VARCHAR, 5, '0'),
    CASE MOD(SEQ4(), 6)
        WHEN 0 THEN 'Screening' WHEN 1 THEN 'Baseline' WHEN 2 THEN 'Week 4'
        WHEN 3 THEN 'Week 12' WHEN 4 THEN 'Week 24' WHEN 5 THEN 'End of Study'
    END,
    DATEADD('day', UNIFORM(0, 700, RANDOM()), '2024-06-01'::DATE),
    CASE WHEN UNIFORM(0, 10, RANDOM()) < 8
        THEN DATEADD('day', UNIFORM(0, 700, RANDOM()), '2024-06-01'::DATE)
        ELSE NULL
    END,
    CASE MOD(SEQ4(), 8)
        WHEN 0 THEN 'SCHEDULED' WHEN 1 THEN 'SCHEDULED'
        WHEN 2 THEN 'MISSED' ELSE 'COMPLETED'
    END,
    CASE MOD(SEQ4(), 5)
        WHEN 0 THEN 'Routine follow-up completed'
        WHEN 1 THEN 'Labs collected per protocol'
        WHEN 2 THEN 'Patient reported improvement'
        WHEN 3 THEN 'ECG and vitals within normal limits'
        WHEN 4 THEN 'Study drug dispensed'
    END,
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 20000));

------------------------------------------------------------------------
-- ADVERSE_EVENTS (2,000 rows)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE ADVERSE_EVENTS (
    AE_ID VARCHAR(15) PRIMARY KEY,
    ENROLLMENT_ID VARCHAR(15),
    AE_TERM VARCHAR(200),
    SEVERITY VARCHAR(10),
    SERIOUS VARCHAR(5),
    CAUSALITY VARCHAR(20),
    ONSET_DATE DATE,
    RESOLUTION_DATE DATE,
    OUTCOME VARCHAR(30),
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO ADVERSE_EVENTS
SELECT
    'AE-' || LPAD(SEQ4()::VARCHAR, 5, '0'),
    'ENR-' || LPAD(UNIFORM(0, 4999, RANDOM())::VARCHAR, 5, '0'),
    CASE MOD(SEQ4(), 15)
        WHEN 0 THEN 'Headache' WHEN 1 THEN 'Nausea' WHEN 2 THEN 'Fatigue'
        WHEN 3 THEN 'Dizziness' WHEN 4 THEN 'Diarrhea' WHEN 5 THEN 'Rash'
        WHEN 6 THEN 'Arthralgia' WHEN 7 THEN 'Cough' WHEN 8 THEN 'Insomnia'
        WHEN 9 THEN 'Injection site reaction' WHEN 10 THEN 'Upper respiratory infection'
        WHEN 11 THEN 'Back pain' WHEN 12 THEN 'Hypertension' WHEN 13 THEN 'Neutropenia'
        WHEN 14 THEN 'Elevated ALT'
    END,
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 'Severe' WHEN 1 THEN 'Severe' WHEN 2 THEN 'Moderate'
        WHEN 3 THEN 'Moderate' WHEN 4 THEN 'Moderate' ELSE 'Mild'
    END,
    CASE WHEN UNIFORM(0, 9, RANDOM()) < 2 THEN 'Yes' ELSE 'No' END,
    CASE MOD(SEQ4(), 4)
        WHEN 0 THEN 'Related' WHEN 1 THEN 'Possibly Related'
        WHEN 2 THEN 'Unlikely' WHEN 3 THEN 'Not Related'
    END,
    DATEADD('day', UNIFORM(0, 600, RANDOM()), '2024-06-01'::DATE),
    CASE WHEN UNIFORM(0, 4, RANDOM()) < 3
        THEN DATEADD('day', UNIFORM(1, 30, RANDOM()), DATEADD('day', UNIFORM(0, 600, RANDOM()), '2024-06-01'::DATE))
        ELSE NULL
    END,
    CASE MOD(SEQ4(), 5)
        WHEN 0 THEN 'Resolved' WHEN 1 THEN 'Resolved' WHEN 2 THEN 'Resolving'
        WHEN 3 THEN 'Ongoing' WHEN 4 THEN 'Resolved with sequelae'
    END,
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 2000));

------------------------------------------------------------------------
-- ELIGIBILITY_CRITERIA (500 rows)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE ELIGIBILITY_CRITERIA (
    CRITERIA_ID VARCHAR(15) PRIMARY KEY,
    TRIAL_ID VARCHAR(20),
    CRITERIA_TYPE VARCHAR(10),
    CRITERIA_TEXT VARCHAR(1000),
    PARAMETER VARCHAR(50),
    MIN_VALUE FLOAT,
    MAX_VALUE FLOAT,
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO ELIGIBILITY_CRITERIA
SELECT
    'CRIT-' || LPAD(SEQ4()::VARCHAR, 4, '0'),
    CASE MOD(SEQ4(), 50)
        WHEN 0 THEN 'CARDIO-PREVENT-301' WHEN 1 THEN 'ONCO-LUNG-201' WHEN 2 THEN 'NEURO-ALZ-102'
        WHEN 3 THEN 'ENDO-DM2-301' WHEN 4 THEN 'RESP-COPD-202' WHEN 5 THEN 'DERM-PSO-301'
        WHEN 6 THEN 'HEMA-CLL-201' WHEN 7 THEN 'CARDIO-HF-202' WHEN 8 THEN 'ONCO-BREAST-301'
        WHEN 9 THEN 'NEURO-MS-301' WHEN 10 THEN 'ENDO-NASH-201' WHEN 11 THEN 'RESP-ASTH-301'
        WHEN 12 THEN 'IMMUNO-RA-202' WHEN 13 THEN 'ONCO-CRC-201' WHEN 14 THEN 'CARDIO-AFib-201'
        WHEN 15 THEN 'NEURO-PD-101' WHEN 16 THEN 'HEMA-AML-301' WHEN 17 THEN 'DERM-AD-202'
        WHEN 18 THEN 'ENDO-OBS-301' WHEN 19 THEN 'RESP-IPF-201' WHEN 20 THEN 'ONCO-PROST-301'
        WHEN 21 THEN 'IMMUNO-SLE-201' WHEN 22 THEN 'CARDIO-PAH-301' WHEN 23 THEN 'NEURO-EPI-301'
        WHEN 24 THEN 'HEMA-MDS-201' WHEN 25 THEN 'ONCO-MELANOMA-201' WHEN 26 THEN 'DERM-VIT-201'
        WHEN 27 THEN 'ENDO-HYPO-301' WHEN 28 THEN 'RESP-BRON-201' WHEN 29 THEN 'IMMUNO-AS-301'
        WHEN 30 THEN 'ONCO-HCC-201' WHEN 31 THEN 'CARDIO-CAD-202' WHEN 32 THEN 'NEURO-MIG-301'
        WHEN 33 THEN 'HEMA-ITP-201' WHEN 34 THEN 'DERM-HSP-201' WHEN 35 THEN 'ENDO-ACRO-201'
        WHEN 36 THEN 'IMMUNO-UC-301' WHEN 37 THEN 'ONCO-PANC-201' WHEN 38 THEN 'RESP-RSV-301'
        WHEN 39 THEN 'NEURO-ALS-201' WHEN 40 THEN 'CARDIO-DVT-301' WHEN 41 THEN 'HEMA-NHL-301'
        WHEN 42 THEN 'ONCO-OVARIAN-201' WHEN 43 THEN 'IMMUNO-CD-301' WHEN 44 THEN 'DERM-ALOPECIA-301'
        WHEN 45 THEN 'ENDO-T1D-201' WHEN 46 THEN 'RESP-CF-301' WHEN 47 THEN 'NEURO-DEPR-301'
        WHEN 48 THEN 'ONCO-GLIO-101' WHEN 49 THEN 'IMMUNO-PSA-301'
    END,
    CASE WHEN MOD(SEQ4(), 3) < 2 THEN 'INCLUSION' ELSE 'EXCLUSION' END,
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 'Age between 18 and 75 years'
        WHEN 1 THEN 'BMI between 20 and 40 kg/m2'
        WHEN 2 THEN 'No active malignancy within past 5 years'
        WHEN 3 THEN 'Adequate hepatic function (ALT < 3x ULN)'
        WHEN 4 THEN 'eGFR >= 30 mL/min/1.73m2'
        WHEN 5 THEN 'No prior exposure to study drug class'
        WHEN 6 THEN 'Willing to provide informed consent'
        WHEN 7 THEN 'LDL cholesterol >= 130 mg/dL'
        WHEN 8 THEN 'No uncontrolled hypertension (SBP > 180)'
        WHEN 9 THEN 'HbA1c between 7.0% and 10.5%'
    END,
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 'AGE' WHEN 1 THEN 'BMI' WHEN 2 THEN 'MALIGNANCY'
        WHEN 3 THEN 'ALT' WHEN 4 THEN 'EGFR' WHEN 5 THEN 'PRIOR_THERAPY'
        WHEN 6 THEN 'CONSENT' WHEN 7 THEN 'LDL' WHEN 8 THEN 'SBP'
        WHEN 9 THEN 'HBA1C'
    END,
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 18 WHEN 1 THEN 20 WHEN 2 THEN NULL
        WHEN 3 THEN NULL WHEN 4 THEN 30 WHEN 5 THEN NULL
        WHEN 6 THEN NULL WHEN 7 THEN 130 WHEN 8 THEN NULL
        WHEN 9 THEN 7.0
    END,
    CASE MOD(SEQ4(), 10)
        WHEN 0 THEN 75 WHEN 1 THEN 40 WHEN 2 THEN NULL
        WHEN 3 THEN 3 WHEN 4 THEN NULL WHEN 5 THEN NULL
        WHEN 6 THEN NULL WHEN 7 THEN NULL WHEN 8 THEN 180
        WHEN 9 THEN 10.5
    END,
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 500));

------------------------------------------------------------------------
-- PROTOCOL_DOCUMENTS (100 rows)
------------------------------------------------------------------------
CREATE OR REPLACE TABLE PROTOCOL_DOCUMENTS (
    DOCUMENT_ID VARCHAR(15) PRIMARY KEY,
    TRIAL_ID VARCHAR(20),
    DOCUMENT_TYPE VARCHAR(30),
    TITLE VARCHAR(500),
    CONTENT VARCHAR(16000),
    VERSION VARCHAR(10),
    EFFECTIVE_DATE DATE,
    CREATED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

INSERT INTO PROTOCOL_DOCUMENTS
SELECT
    'DOC-' || LPAD(SEQ4()::VARCHAR, 4, '0'),
    CASE MOD(SEQ4(), 50)
        WHEN 0 THEN 'CARDIO-PREVENT-301' WHEN 1 THEN 'ONCO-LUNG-201' WHEN 2 THEN 'NEURO-ALZ-102'
        WHEN 3 THEN 'ENDO-DM2-301' WHEN 4 THEN 'RESP-COPD-202' WHEN 5 THEN 'DERM-PSO-301'
        WHEN 6 THEN 'HEMA-CLL-201' WHEN 7 THEN 'CARDIO-HF-202' WHEN 8 THEN 'ONCO-BREAST-301'
        WHEN 9 THEN 'NEURO-MS-301' WHEN 10 THEN 'ENDO-NASH-201' WHEN 11 THEN 'RESP-ASTH-301'
        WHEN 12 THEN 'IMMUNO-RA-202' WHEN 13 THEN 'ONCO-CRC-201' WHEN 14 THEN 'CARDIO-AFib-201'
        WHEN 15 THEN 'NEURO-PD-101' WHEN 16 THEN 'HEMA-AML-301' WHEN 17 THEN 'DERM-AD-202'
        WHEN 18 THEN 'ENDO-OBS-301' WHEN 19 THEN 'RESP-IPF-201' WHEN 20 THEN 'ONCO-PROST-301'
        WHEN 21 THEN 'IMMUNO-SLE-201' WHEN 22 THEN 'CARDIO-PAH-301' WHEN 23 THEN 'NEURO-EPI-301'
        WHEN 24 THEN 'HEMA-MDS-201' WHEN 25 THEN 'ONCO-MELANOMA-201' WHEN 26 THEN 'DERM-VIT-201'
        WHEN 27 THEN 'ENDO-HYPO-301' WHEN 28 THEN 'RESP-BRON-201' WHEN 29 THEN 'IMMUNO-AS-301'
        WHEN 30 THEN 'ONCO-HCC-201' WHEN 31 THEN 'CARDIO-CAD-202' WHEN 32 THEN 'NEURO-MIG-301'
        WHEN 33 THEN 'HEMA-ITP-201' WHEN 34 THEN 'DERM-HSP-201' WHEN 35 THEN 'ENDO-ACRO-201'
        WHEN 36 THEN 'IMMUNO-UC-301' WHEN 37 THEN 'ONCO-PANC-201' WHEN 38 THEN 'RESP-RSV-301'
        WHEN 39 THEN 'NEURO-ALS-201' WHEN 40 THEN 'CARDIO-DVT-301' WHEN 41 THEN 'HEMA-NHL-301'
        WHEN 42 THEN 'ONCO-OVARIAN-201' WHEN 43 THEN 'IMMUNO-CD-301' WHEN 44 THEN 'DERM-ALOPECIA-301'
        WHEN 45 THEN 'ENDO-T1D-201' WHEN 46 THEN 'RESP-CF-301' WHEN 47 THEN 'NEURO-DEPR-301'
        WHEN 48 THEN 'ONCO-GLIO-101' WHEN 49 THEN 'IMMUNO-PSA-301'
    END,
    CASE MOD(SEQ4(), 4)
        WHEN 0 THEN 'Protocol Synopsis' WHEN 1 THEN 'Informed Consent'
        WHEN 2 THEN 'Statistical Analysis Plan' WHEN 3 THEN 'Investigator Brochure'
    END,
    CASE MOD(SEQ4(), 4)
        WHEN 0 THEN 'Protocol Synopsis - Study Design, Objectives, and Endpoints'
        WHEN 1 THEN 'Informed Consent Form - Patient Rights and Study Procedures'
        WHEN 2 THEN 'Statistical Analysis Plan - Primary and Secondary Endpoint Analysis'
        WHEN 3 THEN 'Investigator Brochure - Preclinical and Clinical Summary'
    END,
    CASE MOD(SEQ4(), 4)
        WHEN 0 THEN 'This Phase III, randomized, double-blind, placebo-controlled study evaluates the efficacy and safety of the investigational product in patients with confirmed diagnosis. The primary objective is to demonstrate superiority over placebo in reducing the primary endpoint. Approximately ' || (MOD(SEQ4(), 30) + 1) * 100 || ' patients will be enrolled across multiple international sites in the Asia-Pacific region. The study duration is approximately 24 months with visits at screening, baseline, and every 4 weeks thereafter. Key inclusion criteria include age 18-75, confirmed diagnosis, and adequate organ function. Key exclusion criteria include prior treatment with same mechanism of action, active malignancy, and uncontrolled comorbidities.'
        WHEN 1 THEN 'You are being asked to participate in a clinical research study. Before you decide, it is important that you understand why the research is being done and what it will involve. Please take time to read the following information carefully. The purpose of this study is to evaluate a new investigational treatment. Your participation is voluntary and you may withdraw at any time without affecting your standard medical care. The study involves regular clinic visits, blood tests, imaging studies, and completion of questionnaires. Potential risks include those associated with the study medication and standard clinical procedures. Benefits may include improvement in your condition, though this cannot be guaranteed.'
        WHEN 2 THEN 'The statistical analysis plan describes the planned analyses for the primary and secondary endpoints. The primary analysis will use a mixed-effects model for repeated measures (MMRM) with treatment, visit, treatment-by-visit interaction, and baseline value as covariates. The primary endpoint will be tested at a two-sided significance level of 0.05. Multiple testing will be controlled using a hierarchical testing procedure. Sample size calculations are based on an assumed treatment difference of 15% with 90% power. Sensitivity analyses include tipping point analysis, pattern mixture models, and per-protocol population analysis.'
        WHEN 3 THEN 'The investigator brochure provides a comprehensive summary of the nonclinical and clinical data relevant to the study of the investigational product in human subjects. The compound demonstrates selective mechanism of action with favorable pharmacokinetic properties including oral bioavailability >60%, half-life of 12-18 hours supporting once-daily dosing, and linear pharmacokinetics across the therapeutic dose range. Preclinical toxicology studies in rats and dogs showed acceptable safety margins. Clinical pharmacology studies in healthy volunteers demonstrated dose-proportional exposure and no clinically significant food effect.'
    END,
    'v' || (MOD(SEQ4(), 3) + 1) || '.0',
    DATEADD('day', -UNIFORM(30, 365, RANDOM()), CURRENT_DATE()),
    CURRENT_TIMESTAMP()
FROM TABLE(GENERATOR(ROWCOUNT => 100));
