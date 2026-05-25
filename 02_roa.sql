SELECT 
    f102.bank_name,
    f102.year,
    ROUND(f102.sim_itogo) AS profit,
    ROUND(f101.assets) AS assets,
    ROUND(f102.sim_itogo / NULLIF(f101.assets, 0) * 100, 2) AS roa_percent
FROM
    (SELECT bank_name, year, sim_itogo
     FROM form102
     WHERE code = '1000') f102
JOIN
    (SELECT bank_name, year,
     SUM(CASE WHEN num_sc = 'ITGAP' AND a_p = 1 THEN iitg ELSE 0 END) AS assets
     FROM form101
     GROUP BY bank_name, year) f101
ON f102.bank_name = f101.bank_name AND f102.year = f101.year
ORDER BY f102.bank_name, f102.year;