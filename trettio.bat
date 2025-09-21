@echo off
title TRETTIO Utility
color 0a
:menu
cls
echo.
echo  /$$$$$$$$ /$$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$$$ /$$$$$$  /$$$$$$ 
echo |__  $$__/| $$__  $$| $$_____/|__  $$__/|__  $$__/|_  $$_/ /$$__  $$
echo    | $$   | $$  \ $$| $$         | $$      | $$     | $$  | $$  \ $$
echo    | $$   | $$$$$$$/| $$$$$      | $$      | $$     | $$  | $$  | $$
echo    | $$   | $$__  $$| $$__/      | $$      | $$     | $$  | $$  | $$
echo    | $$   | $$  \ $$| $$         | $$      | $$     | $$  | $$  | $$
echo    | $$   | $$  | $$| $$$$$$$$   | $$      | $$    /$$$$$$|  $$$$$$/
echo    |__/   |__/  |__/|________/   |__/      |__/   |______/ \______/ 
echo.
echo                TRETTIO Utility
echo. ---------------------------------------------------
echo [ 1 ] Clean Logs & Crash Dumps  - Deletes log/crash files
echo [ 2 ] Remove Orphaned Shortcuts - Cleans up broken links
echo [ 3 ] Basic Repair Tools        - Flush DNS, check disk, etc.
echo [ 4 ] Exit
echo ---------------------------------------------------
echo.

set /p choice=Select an option (1-4): 

if "%choice%"=="1" goto cleanlogs
if "%choice%"=="2" goto removeshortcuts
if "%choice%"=="3" goto repair
if "%choice%"=="4" exit
goto menu

:cleanlogs
cls
echo Cleaning logs and crash dumps...
:: Delete Windows crash dumps
del /f /q "%LocalAppData%\CrashDumps\*.*" >nul 2>&1
:: Delete Windows log files
del /f /q "%windir%\Logs\*.*" >nul 2>&1
del /f /q "%windir%\Temp\*.log" >nul 2>&1
echo Done!
pause
goto menu

:removeshortcuts
cls
echo Removing orphaned shortcuts...
for /r "%userprofile%\Desktop" %%i in (*.lnk) do (
    if not exist "%%~fi\.." (
        del "%%i"
    )
)
for /r "%appdata%\Microsoft\Windows\Start Menu\Programs" %%i in (*.lnk) do (
    if not exist "%%~fi\.." (
        del "%%i"
    )
)
echo Done!
pause
goto menu

:repair
cls
echo Running basic repair tasks...
echo Flushing DNS...
ipconfig /flushdns >nul
echo Checking disk for quick errors...
chkdsk C: /f /scan
echo Clearing temporary files...
del /f /q "%temp%\*.*" >nul 2>&1
echo Done!
pause
goto menu
