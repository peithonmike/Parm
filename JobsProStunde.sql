SELECT 
  substring(cmr_runinf.timestmp from 1 for 10) AS "Datum",
  COUNT (cmr_runinf.jobno) AS "Anzahl Jobs/Stunde"
FROM 
  public.cmr_runinf
WHERE (cmr_runinf.timestmp >= '20160508*' AND cmr_runinf.timestmp < '20160509*')
GROUP BY substring(cmr_runinf.timestmp from 1 for 10)
ORDER BY substring(cmr_runinf.timestmp from 1 for 10);
