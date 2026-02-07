@echo off
title Windows Optimization Script
echo Applying settings, please wait...
echo -----------------------------------------

:: 1. Restrict Background Apps (AppPrivacy)
echo [1/4] Disabling background apps...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f

:: 2. Ethernet MTU Setting (Ensure interface name is 'Ethernet')
echo [2/4] Setting Ethernet MTU to 1492...
netsh interface ipv4 set subinterface "Ethernet" mtu=1492 store=persistent

:: 3. BCD (Boot Configuration Data) Settings
echo [3/4] Applying BCD settings (Tick, PlatformClock, TSCSync)...
bcdedit /set disabledynamictick yes
bcdedit /set useplatformclock no
bcdedit /set tscsyncpolicy enhanced

:: 4. NVIDIA DisableDynamicPstate Setting
:: Note: Using %% for loop variables inside a bat file.
echo [4/4] Disabling NVIDIA Dynamic P-State...
for /f "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}" /t REG_SZ /s /e /f "NVIDIA" ^| findstr "HK"') do (
    reg add "%%a" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
    echo Applied to: %%a
)

echo -----------------------------------------
echo All operations completed.
echo A restart is recommended for changes to take effect.
pause
