SELECT TOP 5 * FROM TelCom_data;

SELECT TOP 10 * FROM TelCom_data;


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TelCom_data';

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN [IMSI] IS NULL THEN 1 ELSE 0 END) AS imsi_nulls,
    SUM(CASE WHEN [MSISDN/Number] IS NULL THEN 1 ELSE 0 END) AS msisdn_nulls,
    SUM(CASE WHEN [Handset_Manufacturer] IS NULL THEN 1 ELSE 0 END) AS manufacturer_nulls,
    SUM(CASE WHEN [Handset_Type] IS NULL THEN 1 ELSE 0 END) AS handset_nulls
FROM TelCom_data;


SELECT 
    AVG([Total_UL_(Bytes)]) AS avg_upload,
    AVG([Total_DL_(Bytes)]) AS avg_download,
    AVG([total_traffic]) AS avg_total_traffic
FROM TelCom_data;

SELECT 
    [MSISDN/Number], 
    [Total_DL_(Bytes)], 
    [Total_UL_(Bytes)], 
    [total_traffic]
FROM TelCom_data
ORDER BY [total_traffic] DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- By Hour
SELECT [session_hour], COUNT(*) AS session_count
FROM TelCom_data
GROUP BY [session_hour]
ORDER BY [session_hour];

-- By Day of Week
SELECT [session_dayofweek], COUNT(*) AS session_count
FROM TelCom_data
GROUP BY [session_dayofweek]
ORDER BY [session_dayofweek];

SELECT [decile_class], COUNT(*) AS user_count
FROM TelCom_data
GROUP BY [decile_class]
ORDER BY [decile_class];

SELECT 
    AVG([Avg_RTT_DL_(ms)]) AS avg_rtt_dl,
    AVG([Avg_RTT_UL_(ms)]) AS avg_rtt_ul,
    AVG([Avg_Bearer_TP_DL_(kbps)]) AS avg_dl_tp,
    AVG([Avg_Bearer_TP_UL_(kbps)]) AS avg_ul_tp
FROM TelCom_data;

SELECT 
    [MSISDN/Number], 
    [Youtube_DL_(Bytes)], 
    [Gaming_DL_(Bytes)],
    [Netflix_DL_(Bytes)]
FROM TelCom_data
ORDER BY [Youtube_DL_(Bytes)] DESC;

SELECT 
    [MSISDN/Number],
    [Social_Media_DL_(Bytes)] + [Social_Media_UL_(Bytes)] AS total_social,
    [Google_DL_(Bytes)] + [Google_UL_(Bytes)] AS total_google,
    [Email_DL_(Bytes)] + [Email_UL_(Bytes)] AS total_email
FROM TelCom_data
ORDER BY total_social DESC;

SELECT 
    [MSISDN/Number],
    [Social_Media_DL_(Bytes)] + [Social_Media_UL_(Bytes)] AS total_social,
    [Google_DL_(Bytes)] + [Google_UL_(Bytes)] AS total_google,
    [Email_DL_(Bytes)] + [Email_UL_(Bytes)] AS total_email
FROM TelCom_data
ORDER BY total_social DESC;

SELECT 
    AVG([DL_TP_<_50_Kbps_(%)]) AS pct_dl_below_50,
    AVG([DL_TP_>_1_Mbps_(%)]) AS pct_dl_above_1mbps,
    AVG([UL_TP_<_10_Kbps_(%)]) AS pct_ul_below_10,
    AVG([UL_TP_>_300_Kbps_(%)]) AS pct_ul_above_300
FROM TelCom_data;

SELECT 
    [MSISDN/Number], 
    COUNT(*) AS occurrences
FROM TelCom_data
GROUP BY [MSISDN/Number]
HAVING COUNT(*) > 1;

Filter by Specific Date and Time Range:
SELECT *
FROM TelCom_data
WHERE [Start] >= '2025-04-01 00:00:00' AND [End] <= '2025-04-21 23:59:59';

Filter Sessions with High Data Traffic:
SELECT *
FROM TelCom_data
WHERE ([Total_DL_(Bytes)] + [Total_UL_(Bytes)]) > 100000000; -- Example threshold

Filter by Network Performance Issues:
SELECT *
FROM TelCom_data
WHERE [Avg_RTT_DL_(ms)] > 100 OR [Avg_RTT_UL_(ms)] > 100; -- Example RTT threshold

Filter by Specific Handset Manufacturer:
SELECT *
FROM TelCom_data
WHERE Handset_Manufacturer = 1;



SELECT 
    [MSISDN/Number], 
    [session_duration]
FROM TelCom_data
ORDER BY [session_duration] DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

Average Session Duration by Day of the Week:
SELECT session_dayofweek, AVG(session_duration) AS Avg_Duration
FROM TelCom_data
GROUP BY session_dayofweek
ORDER BY session_dayofweek;

Find Top Manufacturers with Traffic:

SELECT Handset_Manufacturer, 
       SUM([Total_DL_(Bytes)] + [Total_UL_(Bytes)]) AS Total_Traffic
FROM TelCom_data
GROUP BY Handset_Manufacturer
ORDER BY Total_Traffic DESC;

Percentage of Slow Download Speeds (<50 Kbps):
SELECT AVG([DL_TP_<_50_Kbps_(%)]) AS Avg_Slow_DL_Percentage
FROM TelCom_data;

Average RTT (Round-Trip Time) per Handset Type:
SELECT Handset_Type, 
       AVG([Avg_RTT_DL_(ms)]) AS Avg_DL_RTT, 
       AVG([Avg_RTT_UL_(ms)]) AS Avg_UL_RTT
FROM TelCom_data
GROUP BY Handset_Type;

Top Social Media Consumers:
SELECT Handset_Manufacturer, 
       SUM([Social_Media_DL_(Bytes)] + [Social_Media_UL_(Bytes)]) AS Social_Media_Traffic
FROM TelCom_data
GROUP BY Handset_Manufacturer
ORDER BY Social_Media_Traffic DESC;

YouTube vs Netflix Traffic:
SELECT 
    SUM([Youtube_DL_(Bytes)] + [Youtube_UL_(Bytes)]) AS Total_YouTube_Traffic,
    SUM([Netflix_DL_(Bytes)] + [Netflix_UL_(Bytes)]) AS Total_Netflix_Traffic
FROM TelCom_data;

Session Frequency Distribution by Decile Class:
SELECT decile_class, 
       AVG(session_frequency) AS Avg_Session_Frequency
FROM TelCom_data
GROUP BY decile_class
ORDER BY decile_class;

Activity Breakdown (Download vs Upload):
SELECT 
    SUM([Activity_Duration_DL_(ms)]) AS Total_DL_Activity,
    SUM([Activity_Duration_UL_(ms)]) AS Total_UL_Activity
FROM TelCom_data;


