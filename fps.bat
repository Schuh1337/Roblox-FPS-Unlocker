@echo off
setlocal enabledelayedexpansion

REM
if not exist "%CD%\ClientSettings" (
    echo ClientSettings folder not found.
    pause
    exit /b
)

REM
set "robloxDirectory="
for /d %%d in ("%LOCALAPPDATA%\Roblox\Versions*") do (
    set "robloxDirectory=%%d"
    goto :foundRoblox
)
:foundRoblox

REM
if not defined robloxDirectory (
    echo Roblox directory not found.
    pause
    exit /b
)

REM
set "movedCount=0"
set "presentCount=0"
set "totalCount=0"

for /d %%i in ("%robloxDirectory%\*") do (
    set /a totalCount+=1
    if not exist "%%i\ClientSettings" (
        xcopy /e /y "%CD%\ClientSettings" "%%i\ClientSettings\" > nul
        echo Moved ClientSettings to %%i
        set /a movedCount+=1
    ) else (
        echo ClientSettings already present in %%i
        set /a presentCount+=1
    )
)

echo.
echo %totalCount% total, %movedCount% moved, %presentCount% present
echo.
pause
endlocal