@echo off
title cullewie999
echo [#] Preparing...

for /f "tokens=4 delims= " %%A in ('powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c') do set NEWGUID=%%A

if "%NEWGUID%"=="" (
  echo [!] Failed to duplicate scheme.
  pause
  exit /b 1
)

echo [#] New GUID is %NEWGUID%
powercfg /changename %NEWGUID% "Cullewie 999"

echo CPU 100% set
powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMAX 100
powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PROCTHROTTLEMAX 100

echo Boost Mode aggressively set
powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR PERFBOOSTMODE 5
powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR PERFBOOSTMODE 5

echo Core Parking disabled
powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR CPMINCORES 100
powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR CPMINCORES 100
powercfg /setacvalueindex %NEWGUID% SUB_PROCESSOR CPMAXCORES 100
powercfg /setdcvalueindex %NEWGUID% SUB_PROCESSOR CPMAXCORES 100

echo PCI Express ASPM disabled
powercfg /setacvalueindex %NEWGUID% SUB_PCIEXPRESS ASPM 0
powercfg /setdcvalueindex %NEWGUID% SUB_PCIEXPRESS ASPM 0

echo USB Selective Suspend disabled
powercfg /setacvalueindex %NEWGUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /setdcvalueindex %NEWGUID% 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0

echo Disk idle timeout disabled
powercfg /setacvalueindex %NEWGUID% SUB_DISK DISKIDLE 0
powercfg /setdcvalueindex %NEWGUID% SUB_DISK DISKIDLE 0

echo Sleep and hibernate disabled
powercfg /setacvalueindex %NEWGUID% SUB_SLEEP STANDBYIDLE 0
powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP STANDBYIDLE 0
powercfg /setacvalueindex %NEWGUID% SUB_SLEEP HIBERNATEIDLE 0
powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP HIBERNATEIDLE 0
powercfg /setacvalueindex %NEWGUID% SUB_SLEEP HYBRIDSLEEP 0
powercfg /setdcvalueindex %NEWGUID% SUB_SLEEP HYBRIDSLEEP 0

echo Video idle timeout disabled
powercfg /setacvalueindex %NEWGUID% SUB_VIDEO VIDEOIDLE 0
powercfg /setdcvalueindex %NEWGUID% SUB_VIDEO VIDEOIDLE 0

echo Multimedia performance mode set
powercfg /setacvalueindex %NEWGUID% 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 1
powercfg /setdcvalueindex %NEWGUID% 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 1

echo Activating power plan
powercfg /setactive %NEWGUID%

echo TimerResolution 0.5ms registry setting applied
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d 1 /f >nul 2>&1

echo [✓] Power plan applied successfully.
echo [!] Please reboot your system.
pause
