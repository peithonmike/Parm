SELECT 
  substring(cmr_runinf.timestmp from 1 for 8) AS "Datum",
  COUNT (cmr_runinf.jobno) AS "Anzahl Jobs/Stunde"
FROM 
  public.cmr_runinf
WHERE (cmr_runinf.timestmp >= '20160504*' AND cmr_runinf.timestmp < '20160524*')
GROUP BY substring(cmr_runinf.timestmp from 1 for 8)
ORDER BY substring(cmr_runinf.timestmp from 1 for 8);
