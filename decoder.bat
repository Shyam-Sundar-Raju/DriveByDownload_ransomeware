@echo off
set /p "pass=Enter Decryption Key: "
if NOT "%pass%"=="Soma123" (
    echo [!] Invalid Key!
    pause
    exit
)

set "target=%USERPROFILE%\Desktop"
set "store=%USERPROFILE%\Documents"
echo [*] Decrypting files...

for /r "%target%" %%f in (*.soma) do (
    set "file=%%f"
    call ren "%%f" "%%~nf"
)

echo [*] Cleaning up malicious traces...
del "%target%\soma.txt"
del "%store%\encoder.bat"
del "%store%\loader.bat"
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\sys_update.bat"

echo [+] System Restored.
start /b "" cmd /c "timeout /t 2 >nul & del %~f0"
exit