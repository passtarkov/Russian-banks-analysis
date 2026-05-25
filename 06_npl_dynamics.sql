WITH npl_data AS (
    SELECT 
        bank_name,
        year,
        ROUND(
            SUM(CASE WHEN num_sc LIKE '458%' THEN iitg ELSE 0 END) /
            NULLIF(SUM(CASE WHEN num_sc LIKE '44%' OR num_sc LIKE '45%' THEN iitg ELSE 0 END), 0) * 100
        , 2) AS npl_percent
    FROM form101
    GROUP BY bank_name, year
)
SELECT 
    cur.bank_name,
    cur.year,
    cur.npl_percent,
    prev.npl_percent AS npl_prev_year,
    ROUND(cur.npl_percent - prev.npl_percent, 2) AS npl_change,
    CASE WHEN cur.year >= 2022 THEN 'После санкций' ELSE 'До санкций' END AS period
FROM npl_data cur
LEFT JOIN npl_data prev 
    ON cur.bank_name = prev.bank_name 
    AND cur.year = prev.year + 1
ORDER BY cur.bank_name, cur.year;