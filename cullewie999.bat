@echo off
setlocal

cls
echo ==========================================
echo      Cullewie999 INSTALLATION
echo ==========================================
echo.

:: --- STAGE 1 ---
:: Trying to duplicate Ultimate Performance scheme
for /f "tokens=4 delims= " %%A in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul') do set NEWGUID=%%A

if "%NEWGUID%"=="" (
    echo [Stage 1] Creating Plan........ FAILED
    echo [!] Error: Ultimate Performance scheme not found.
    pause
    exit /b 1
) else (
    echo [Stage 1] Creating Plan........ SUCCESS
)

:: --- STAGE 2 ---
:: Setting Name and Description
powercfg /changename %NEWGUID% "Cullewie999" "No limits. Pure power. Designed by Cullewie." >nul 2>&1
if %errorlevel% equ 0 (
    echo [Stage 2] Name ^& Description... SUCCESS
) else (
    echo [Stage 2] Name ^& Description... FAILED
)

:: --- STAGE 3 ---
:: Applying Performance Settings silently
(
    powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMIN 100
    powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMIN 100
    powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PERFBOOSTMODE 5
    powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PERFBOOSTMODE 5
    powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR CPMINCORES 100
    powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR CPMINCORES 100
    powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR CPMAXCORES 100
    powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR CPMAXCORES 100
    powercfg /setacvalueindex %NEWGUID% SUB_PCIEXPRESS ASPM 0
    powercfg /setdcvalueindex %NEWGUID% SUB_PCIEXPRESS ASPM 0
    powercfg /setacvalueindex %NEWGUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
    powercfg /setdcvalueindex %NEWGUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
    powercfg /setacvalueindex %NEWGUID% SUB_DISK DISKIDLE 0
    powercfg /setdcvalueindex %NEWGUID% SUB_DISK DISKIDLE 0
    powercfg /setacvalueindex %NEWGUID% SUB_SLEEP STANDBYIDLE 0
    powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP STANDBYIDLE 0
    powercfg /setacvalueindex %NEWGUID% SUB_SLEEP HIBERNATEIDLE 0
    powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP HIBERNATEIDLE 0
    powercfg /setacvalueindex %NEWGUID% SUB_SLEEP HYBRIDSLEEP 0
    powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP HYBRIDSLEEP 0
    powercfg /setacvalueindex %NEWGUID% SUB_VIDEO VIDEOIDLE 0
    powercfg /setdcvalueindex %NEWGUID% SUB_VIDEO VIDEOIDLE 0
    powercfg /setacvalueindex %NEWGUID% 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 1
    powercfg /setdcvalueindex %NEWGUID% 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 1
) >nul 2>&1

echo [Stage 3] Applying Settings.... SUCCESS

:: --- STAGE 4 ---
:: Activating the Plan
powercfg /setactive %NEWGUID% >nul 2>&1
if %errorlevel% equ 0 (
    echo [Stage 4] Activating Plan...... SUCCESS
) else (
    echo [Stage 4] Activating Plan...... FAILED
)

echo.
echo ==========================================
pause
