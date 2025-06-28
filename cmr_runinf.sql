SELECT 
  substring(cmr_runinf.timestmp from 0 for 9),
  COUNT (cmr_runinf.orderno) AS "Anzahl Jobs/Tag"
FROM 
  public.cmr_runinf
GROUP BY substring(cmr_runinf.timestmp from 0 for 9)
