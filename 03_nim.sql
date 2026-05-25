SELECT 
    f102.bank_name,
    f102.year,
    ROUND(f102.nim_income) AS net_interest_income,
    ROUND(f101.assets) AS assets,
    ROUND(f102.nim_income / NULLIF(f101.assets, 0) * 100, 2) AS nim_percent
FROM
    (SELECT bank_name, year, sim_itogo AS nim_income
     FROM form102
     WHERE code = '10003') f102
JOIN
    (SELECT bank_name, year,
     SUM(CASE WHEN num_sc = 'ITGAP' AND a_p = 1 THEN iitg ELSE 0 END) AS assets
     FROM form101
     GROUP BY bank_name, year) f101
ON f102.bank_name = f101.bank_name AND f102.year = f101.year
ORDER BY f102.bank_name, f102.year;