@echo off

:Win32Menu
cls
mode con: cols=82 lines=22
color 3
echo.
echo.                         InfinityTweaks - dsc.gg/infinityxv
echo.                            Win32PrioritySeprationMenu 
echo.
echo.
echo.
echo.            [ 1 ] 26     [ 2 ] 28     [ 3 ] ffff3f91     [ 4 ] fff38a6
echo.
echo.                         [ 5 ] Default                    
echo.
echo.
echo.    [ X ] Exit    [ Q ] Check Value     
echo.
set /p input=Select Option: 
if /i %input% == 1 goto 26
if /i %input% == 2 goto 28
if /i %input% == 3 goto ffff3f91
if /i %input% == 4 goto fff38a6
if /i %input% == 5 goto Default
if /i %input% == x goto MExit
if /i %input% == Q goto CV
) ELSE (
goto MisspellWin32

:MisspellWin32
cls
color
echo Misspell Detected!
goto RedirectWin32

:RedirectWin32
color 3
cls
echo Redirecting.
cls
echo Redirecting..
cls
echo Redirecting...
goto Win32Menu

:26
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f
cls
color 2
echo Successfully set value 26!
goto Win32Menu

:28
cls
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "40" /f
cls
color 2
echo Successfully set value 28!
goto Win32Menu

:ffff3f91
cls
reg add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "4294918033" /f
cls
color 2
echo Successfully set value ffff3f91!
goto Win32Menu

:fff38a6
cls
reg add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "268384422" /f
cls
color 2
echo Successfully set value fff38a6!
goto Win32Menu

:Default
cls
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "2" /f
cls
color 2
echo Successfully set value 2 [Default]!
goto Win32Menu

:CV
cls
setlocal
for /f "tokens=2*" %a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation"') do set "dt=%b"
color E
echo Current Win32Priority : 
goto Win32Menu

:MExit
cls
color 9
echo Exiting.
cls
color 9
echo Exiting..
cls
color 9
echo Exiting...
cls
exit
