-- 1. Determine the number of ads which have generated leads on the site per day.

SELECT DATE_OF_LEAD,COUNT(DISTINCT AD_ID)
FROM SQLTASK
WHERE LEADS IS NOT NULL
GROUP BY DATE_OF_LEAD;

-- 2. Determine the YoY growth of leads in county Dublin from 2018 to 2020 (use lag).

SELECT DATEPART(yyyy,DATE_OF_LEAD) as YEAR,
SUM(LEADS),
FORMAT( ((SUM(LEADS)/convert(float,lag(sum(LEADS)) 
  over( partition by DATEPART(yyyy,DATE_OF_LEAD) order by 
        DATEPART(yyyy,DATE_OF_LEAD))))-1),'p') as YoY_Growth
FROM sqltask
WHERE COUNTY="Dublin" and (DATEPART(yyyy,DATE_OF_LEAD)>=2018
and DATEPART(yyyy,DATE_OF_LEAD)<=2020)
GROUP BY DATEPART(yyyy,DATE_OF_LEAD);