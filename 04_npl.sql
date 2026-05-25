SELECT 
    bank_name,
    year,
    ROUND(SUM(CASE WHEN num_sc LIKE '458%' THEN iitg ELSE 0 END)) AS overdue,
    ROUND(SUM(CASE WHEN num_sc LIKE '44%' OR num_sc LIKE '45%' THEN iitg ELSE 0 END)) AS total_loans,
    ROUND(
        SUM(CASE WHEN num_sc LIKE '458%' THEN iitg ELSE 0 END) /
        NULLIF(SUM(CASE WHEN num_sc LIKE '44%' OR num_sc LIKE '45%' THEN iitg ELSE 0 END), 0) * 100
    , 2) AS npl_percent
FROM form101
GROUP BY bank_name, year
ORDER BY bank_name, year;