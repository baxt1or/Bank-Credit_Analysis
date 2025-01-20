-- 1. Демографический анализ

-- а) Анализ распределения по возрасту
WITH age_distribution_analysis AS (SELECT
CASE 
    WHEN age >= 18 AND age <= 25 THEN 'young'  -- Молодежь
	WHEN age >= 25 AND age <= 40 THEN 'adult'  -- Взрослые
	ELSE 'old'  -- Пожилые
END AS age_group,
SUM(credit_count) AS total_credit_counts,  -- Общее количество кредитов
SUM(overdue_credit_count) AS overdue_credit_counts  -- Количество просроченных кредитов
FROM credit
GROUP BY 1
ORDER BY 2 DESC, 2 DESC),  -- Сортировка по общему количеству кредитов

--  из этого анализа видно, что взрослая группа чаще всего берет кредиты и имеет больше просроченных кредитов

credit_age_analysis AS (SELECT
CASE 
    WHEN age >= 18 AND age <= 25 THEN 'young'  -- Молодежь
	WHEN age >= 25 AND age <= 40 THEN 'adult'  -- Взрослые
	ELSE 'old'  -- Пожилые
END AS age_group,
credit_month, 
COUNT(*)  -- Количество кредитов по месяцам
FROM credit
GROUP BY 1, 2
ORDER BY 2, 3 DESC),  -- Сортировка по месяцам и количеству

-- б) Анализ распределения по полу
gender_analysis AS (SELECT
gender,  -- Пол
ROUND(SUM(CAST(REPLACE(credit_sum, ',', '.') AS NUMERIC)), 2) AS total_sum,  -- Общая сумма кредитов
SUM(credit_count) AS credit_count_total,  -- Общее количество кредитов
SUM(overdue_credit_count) AS overdue_credit_count_total,  -- Общее количество просроченных кредитов
ROUND(AVG(CAST(REPLACE(credit_sum, ',', '.') AS NUMERIC)), 2) AS average_credit_amount  -- Средняя сумма кредита
FROM credit
GROUP BY 1
ORDER BY 2 DESC, 3 DESC, 4 DESC),  -- Сортировка по общей сумме кредита, количеству и просроченным кредитам

-- в) Анализ уровня образования
education_level_analysis AS (SELECT
education,  -- Уровень образования
SUM(CAST(REPLACE(credit_sum, ',', '.') AS NUMERIC)) AS total_credit  -- Общая сумма кредита по уровням образования
FROM credit
GROUP BY 1
ORDER BY 2 DESC),  -- Сортировка по общей сумме кредита

-- 2. Анализ кредитного поведения

-- а) Анализ дохода и суммы кредита
income_vs_credit_sum AS (SELECT
    CASE
        WHEN monthly_income BETWEEN 0 AND 20000 THEN '0-20K'  -- Доход от 0 до 20K
        WHEN monthly_income BETWEEN 20001 AND 40000 THEN '20K-40K'  -- Доход от 20K до 40K
        WHEN monthly_income BETWEEN 40001 AND 60000 THEN '40K-60K'  -- Доход от 40K до 60K
        WHEN monthly_income BETWEEN 60001 AND 80000 THEN '60K-80K'  -- Доход от 60K до 80K
        ELSE '80K+'  -- Доход выше 80K
    END AS income_range,  -- Диапазон дохода
    AVG(CAST(REPLACE(credit_sum, ',', '.') AS NUMERIC)) AS avg_credit_sum  -- Средняя сумма кредита для каждого диапазона дохода
FROM credit
GROUP BY 1
ORDER BY 2 DESC),  -- Сортировка по средней сумме кредита

-- б) Анализ поведения по просроченным кредитам
credit_overdue_analysis AS (SELECT
credit_month,  -- Месяц кредита
ROUND(SUM(overdue_credit_count)::NUMERIC, 2) AS total_overdue_credit  -- Общее количество просроченных кредитов по месяцам
FROM credit
GROUP BY 1
ORDER BY 1, 2 DESC),  -- Сортировка по месяцам и количеству просроченных кредитов

-- в) Анализ просроченных кредитов по должностям
credit_default_for_job_position_analysis AS (SELECT
job_position,  -- Должность
ROUND(AVG(monthly_income)::NUMERIC, 2) AS avg_monthly_income,  -- Средний доход по должности
SUM(overdue_credit_count) AS total_overdue_credit_sum  -- Общее количество просроченных кредитов по должности
FROM credit
WHERE overdue_credit_count IS NOT NULL  -- Исключаем записи с нулевыми значениями просроченных кредитов
GROUP BY 1
ORDER BY 2 DESC, 3 DESC)  -- Сортировка по средней зарплате и количеству просроченных кредитов






