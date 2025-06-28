@echo off
       SET startzeit=%date% %time:~0,8%
       ver
echo   **  Computername: %COMPUTERNAME%
echo   **********************************************************************************
echo   **  STANDARDBATCH.BAT                                 ****************************
echo   **                                                    ****************************
echo   **********************************************************************************
echo   **  Job/Step Start: %date% %time:~0,8%
echo   **********************************************************************************
echo   **  ITK Rheinland                                     ****************************
echo   **  zv173x2                                           ****************************
echo   **********************************************************************************
echo   **  User  : '%USERNAME%'
echo   **  Owner : '%OWNER%'
echo   **********************************************************************************


echo   *--------------------------------------------------------------------------------*
echo   *-                                                                               -*
echo   *-                                                                              -*
echo   *--------------------------------------------------------------------------------*


::**************
:START
::**************
::     ----------------------------------------------------------------------------------
::     Grundsätzliches vor der Verarbeitung abfragen
::     ----------------------------------------------------------------------------------
       if [%TEST%]          == [] set TEST=N
       if %TEST%            == J   call \\wts87\c_Bmc\CTM_AV\Bin\BAT\OK.EWO-TEST-MSG.BAT

echo   ----------------------------------------------------------------------------------
echo   ----------------------------------------------------------------------------------
echo   -           Jobname      : %JOBNAME%
echo   ----------------------------------------------------------------------------------
echo   ----------------------------------------------------------------------------------
echo   STADT / ORT              : %STADT% %ORT%
echo   ----------------------------------------------------------------------------------
echo   JOBNAME                  : %JOBNAME%
echo   Tabelle                  : %TABLE%
echo   ID /RUNNR                : %ID% /%RUNNR% 
echo   ----------------------------------------------------------------------------------
echo   ODATE_WDAY /ODATE_P      : %ODATE_WDAY% /%ODATE_P%
echo   ----------------------------------------------------------------------------------
echo.
echo   Behördennummer für den Datenaustausch über OpenFT mit dem Bundesamt für Justiz (BfJ)
echo   BFJ_ID_OKEWO             : %BFJ_ID_OKEWO%
echo   BFJ_ID_OKVISA            : %BFJ_ID_OKVISA%
echo   ----------------------------------------------------------------------------------
echo   INPUT                    : %INPUT%
echo   OUTPUT                   : %OUTPUT%



::     ----------------------------------------------------------------------------------
::     im Testmodus Hauptprogramm überspringen
::     ----------------------------------------------------------------------------------
       if %TEST% ==J  goto lnotes_test




::**************
:MAIN_PRG
::**************

echo   *************************************************************************
echo   Aufruf  (Hauptverarbeitung)
echo   *************************************************************************
       ::call ft -b %INPUT% toBZR!%OUTPUT% ft#98Hpg6
       if %errorlevel% ==1 goto error_??





::**************
:SEND_MAIL
::**************
::     ----------------------------------------------------------------------------------
::     Attach als Mail versenden
::     ----------------------------------------------------------------------------------
       if %SENDMAIL% == J call \\wts87\c$\CTM_AV\Bin\BAT\SENDMAIL.bat
       if NOT %errorlevel%==0  goto error_mail






goto lnotes_0





::*****************************************************************************************
::*****************************************************************************************
::*****************************************************************************************
:lnotes_0
 set message=Job Ended OK
 set cc=0
 goto ende

:lnotes_test
 set message=Testmodus angefordert
 set cc=8
 goto ende

:error_mail
 set message=Fehler bei der Mail Verarbeitung
 set cc=8
 goto ende



:error_checkbat
 set message=Job Abbruch
 set message2=Checkbat Datei %CHECKBAT% nicht gefunden
 set  cc=16
 goto ende

:error_check
 set message=Job Abbruch
 set cc=20
 goto ende




:ende
        SET endezeit=%date% %time:~0,8%

 echo   ----------------------------------------------------------------------------------
 echo   -                                                                                -
 echo   -     J O B    E N D E                                                           -
 echo   -                                                                                -
 echo   -                                                                                -
 echo   ----------------------------------------------------------------------------------
 echo   -      lnotes Code : %cc%
 echo   -                  %message%
 echo   -                  %message2%
 echo   -                  %message3%
 echo   -       Jobstart : %startzeit%
 echo   -       Jobende  : %endezeit%
 echo   ----------------------------------------------------------------------------------

 ::     -------------------------------------------------------------------------------------------------
 ::     -  Logdatei schreiben
 ::     -  Test wird nicht geschrieben
 ::     -------------------------------------------------------------------------------------------------
        if NOT %TEST% == J  call \\msbmcc03\c_bmc\ctm_av\bin\bat\JOB-LOG.bat


 echo   ----------------------------------------------------------------------------------
 echo   -   CTM Meldungen
 echo   ----------------------------------------------------------------------------------

        lnotes %cc%




