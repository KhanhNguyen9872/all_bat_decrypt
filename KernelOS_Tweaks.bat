@echo off
title KernelOS Tweaks
color a
cd C:\Windows\system32
taskkill /f /im explorer.exe
call :{VfNqzva}
cls
echo.
echo					#    #                                    #######  #####  
echo 				#   #  ###### #####  #    # ###### #      #     # #     # 
echo 				#  #   #      #    # ##   # #      #      #     # #       
echo 				###    #####  #    # # #  # #####  #      #     #  #####  
echo 				#  #   #      #####  #  # # #      #      #     #       # 
echo 				#   #  #      #   #  #   ## #      #      #     # #     # 
echo 				#    # ###### #    # #    # ###### ###### #######  ##### 
powershell "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
echo.
echo                                                   SELECT YOUR LANGUAGE
echo                                                   SELECCIONA TU IDIOMA
echo.
echo                                                      --------------
echo                                                      - 1. Espanol -
echo                                                      - 2. English -
echo                                                      --------------
set /p lang=                                         -----:
if  EQU 1 goto {RFC}
if  EQU 2 goto {RAT}                                             
:{RFC}
::Instalar cosas

echo Importando powerplan de KernelOS
::Importar Powerplans
goto {arkgcbj2}

:{arkgcbj2}
cls
echo Instalando OpenShell y 7zip
C:\Windows\oss.exe /qn ADDLOCAL=StartMenu
C:\Windows\7zip.exe /S

::Eliminar Instaladores, apps, etc.
cls
echo.
echo Eliminando archivos basura.
del /F /Q "C:\Windows\System32\taskhostw.exe"
del /F /Q "C:\Windows\oss.exe"
del /F /Q "C:\Windows\7zip.exe"
del /F /Q "C:\Windows\KernelOS Performance v5.pow"
del /F /Q "C:\Windows\KernelOS Performance v5 Idle On.pow"

::Configurando 7Zip
cls
echo Configurando 7zip.
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\7zipc.bat /start

::Instalar DirectX
cls
echo Instalando DirectX.
start /wait C:\Windows\Temp\DirectX\DXSETUP.exe /silent
echo Instalacion completada.

::Instalar Visuals
cls
echo Instalando Microsoft Visual Runtimes.
echo 2005...
start /wait C:\Windows\Temp\VisualAIO\vcredist2005_x86.exe /q
start /wait C:\Windows\Temp\VisualAIO\vcredist2005_x64.exe /q

echo 2008...
start /wait C:\Windows\Temp\VisualAIO\vcredist2008_x86.exe /qb
start /wait C:\Windows\Temp\VisualAIO\vcredist2008_x64.exe /qb

echo 2010...
start /wait C:\Windows\Temp\VisualAIO\vcredist2010_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2010_x64.exe /passive /norestart

echo 2012...
start /wait C:\Windows\Temp\VisualAIO\vcredist2012_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2012_x64.exe /passive /norestart

echo 2013...
start /wait C:\Windows\Temp\VisualAIO\vcredist2013_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2013_x64.exe /passive /norestart

echo 2015, 2017 & 2019 & 2022...
start /wait C:\Windows\Temp\VisualAIO\vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2015_2017_2019_2022_x64.exe /passive /norestart
echo Instalacion completada correctamente.

:: Auto split SVCHOST
:: Credits; Revision
cls
echo.
echo Modificando SVCHOST.
for /f "tokens=2 delims==" %i in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%i
set /a ram= + 1024000
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "" /f

::BCDEDIT SETTINGS
echo.
echo Modificando BCDedit.
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\bcdtweaks.bat /start

::Deshabilitar opciones adaptador de red
echo.
echo Deshabilitando IPv6 y Microsoft Networks.


::Configuracion adaptador de red
::Credits AtlasOS
cls
echo.
echo Configuracion basica del adaptador de red.

::Configurar Device Manager
::Nirsoft Software
echo.
echo Configurando Device Manager.
echo.
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\dmvt.bat /start

::Tweaks de internet
echo.
cls
choice /c yn /n /m "Quieres ejecutar algunas optimizaciones para tu Internet? Y/N: "
if 0 EQU 1 goto {argpbas2}
if 0 EQU 2 goto {pbag2}

:{argpbas2}
echo.
echo Aplicando configuraciones para Internet.
netsh int tcp set global autotuninglevel=experimental
netsh int tcp set global ecncapability=enabled
netsh int tcp set global netdma=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global initialrto=300
netsh int ip set global minmtu=576
echo.
echo SI NOTAS UN PEOR FUNCIONAMIENTO DE LA RED SIMPLEMENTE EJECUTA EL ARCHIVO DEL ESCRITORIO LLAMADO "INTERNET DEFAULT".
goto {pbag2}

:{pbag2}
::Nagle Algorithm
cls
echo Deshabilitando Nagle Algorithm
for /f %i in ('wmic path win32_networkadapter get GUID | findstr "{"') do (
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
    reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
)

::WIN32 Priority
cls
echo.
echo Modificando Win32Priority.
echo.
echo EL WIN32 DEFAULT ES 26 HEX.
echo.
echo SI NO SABES LO QUE ES ESTO O NO LOS PROBASTE CON ANTERIORIDAD SELECCIONA "N".
echo PUEDES APLICARLOS LUEGOS EN LA CARPETA DEL POST-INSTALL.
choice /c yn /n /m "Quieres seleccionar un Win32 experimental? Y/N: "
if 0 EQU 1 goto {jrkc2}
if 0 EQU 2 goto {jqrs2}

:{jqrs2}
echo Aplicando 26 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
goto {pbag2r}
:{jrkc2}
echo.
echo Selecciona algun Win32.
echo. 
echo 1. fffff311
echo 2. 26666475
echo 3. 1FFFFFE62
set /p w32sel=:

if  EQU 1 goto {sssss311r}
if  EQU 2 goto {26666475r}
if  EQU 3 goto {1SSSSSR62r}

:{sssss311r}
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "4294963985" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "4294963985" /f
goto {pbag2r}
:{26666475r}
echo Applying 26666475 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_QWORD /d "644244597" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_QWORD /d "644244597" /f
goto {pbag2r}
:{1SSSSSR62r}
echo Applying 1FFFFFE62 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "536870498" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "536870498" /f
goto {pbag2r}



::Configs basicas
:{pbag2r}

::Deshabilitar algunos servicios
cls
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LxpSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WManSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SamSs" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Beep" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\peauth" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wcifs" /v "Start" /t REG_DWORD /d "3" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f
cls
choice /c yn /n /m "Utilizas el Firewall de Windows? Y/N: "
IF 0 EQU 1 goto {jvsv2}
IF 0 EQU 2 goto {absverjnyy2}

:{absverjnyy2}
echo.
echo Deshabilitando Firewall
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "4" /f
goto {jvsv2}

:{jvsv2}
echo.
choice /c yn /n /m "Utilizas Wi-Fi? Y/N: "
IF 0 EQU 1 goto {qbar2}
IF 0 EQU 2 goto {abjvsv2}

:{abjvsv2}
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Wcmsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d "4" /f

:{qbar2}
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /V "DisableSecuritySettingsCheck" /T "REG_DWORD" /D "00000001" /F
cls
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\mkScript.bat /start
echo.
echo Por favor espera...
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\PostScript.bat /start
del /F /Q "C:\Windows\Temp\dmvt.bat"
del /F /Q "C:\Windows\Temp\dmv.exe"
shutdown -r -f -t 7 -c "Por favor espera hasta que tu PC se reinicie..."
exit


:{RAT}
::Instalar cosas

echo Importing KernelOS Powerplan
::Importar Powerplans
goto {arkgcbj}

:{arkgcbj}
cls
echo Installing OpenShell and 7zip
C:\Windows\oss.exe /qn ADDLOCAL=StartMenu
C:\Windows\7zip.exe /S

::Eliminar Instaladores, apps, etc.
cls
echo.
echo Deleting junk files.
del /F /Q "C:\Windows\System32\taskhostw.exe"
del /F /Q "C:\Windows\oss.exe"
del /F /Q "C:\Windows\7zip.exe"
del /F /Q "C:\Windows\KernelOS Performance v5.pow"
del /F /Q "C:\Windows\KernelOS Performance v5 Idle On.pow"

::Configurando 7Zip
cls
echo Applying 7zip Settings.
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\7zipc.bat /start

cls
echo Installing DirectX.
start /wait C:\Windows\Temp\DirectX\DXSETUP.exe /silent
echo Installation completed.

::Instalar Visuals
cls
echo Installing Visual Runtimes
echo 2005...
start /wait C:\Windows\Temp\VisualAIO\vcredist2005_x86.exe /q
start /wait C:\Windows\Temp\VisualAIO\vcredist2005_x64.exe /q

echo 2008...
start /wait C:\Windows\Temp\VisualAIO\vcredist2008_x86.exe /qb
start /wait C:\Windows\Temp\VisualAIO\vcredist2008_x64.exe /qb

echo 2010...
start /wait C:\Windows\Temp\VisualAIO\vcredist2010_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2010_x64.exe /passive /norestart

echo 2012...
start /wait C:\Windows\Temp\VisualAIO\vcredist2012_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2012_x64.exe /passive /norestart

echo 2013...
start /wait C:\Windows\Temp\VisualAIO\vcredist2013_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2013_x64.exe /passive /norestart

echo 2015, 2017 & 2019 & 2022...
start /wait C:\Windows\Temp\VisualAIO\vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait C:\Windows\Temp\VisualAIO\vcredist2015_2017_2019_2022_x64.exe /passive /norestart

:: Auto split SVCHOST
:: Credits; Revision
cls
echo.
echo Tweaking Svchost
for /f "tokens=2 delims==" %i in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%i
set /a ram= + 1024000
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "" /f

::BCDEDIT SETTINGS
echo.
echo Tweaking BCDedit
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\bcdtweaks.bat /start

::Deshabilitar opciones adaptador de red
echo.
echo Disabling IPv6 and Microsoft Networks.


::Configuracion adaptador de red
::Credits AtlasOS
cls
echo.
echo Basic network adapter tweaks

::Configurar Device Manager
::Nirsoft Software
echo.
echo Tweaking Device Manager
echo.
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\dmvt.bat /start

::Tweaks de internet
echo.
cls
choice /c yn /n /m "Do you want to run some internet optimizations? Y/N: "
if 0 EQU 1 goto {argpbas}
if 0 EQU 2 goto {pbag}

:{argpbas}
echo.
echo Applying Internet tweaks
netsh int tcp set global autotuninglevel=experimental
netsh int tcp set global ecncapability=enabled
netsh int tcp set global netdma=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global initialrto=300
netsh int ip set global minmtu=576
echo.
echo IF YOU NOTICE A WORSE NETWORK PERFORMANCE SIMPLY RUN THE DESKTOP FILE CALLED "INTERNET DEFAULT".
goto {pbag}

:{pbag}
::Nagle Algorithm
cls
echo Disabling Nagle Algorithm
for /f %i in ('wmic path win32_networkadapter get GUID | findstr "{"') do (
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
    reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
)

::WIN32 Priority
cls
echo.
echo Tweaking Win32Priority.
echo.
echo DEFAULT WIN32 IS 26 HEX.
echo.
echo IF YOU DO NOT KNOW WHAT THIS IS OR YOU HAVE NOT TEST THEM BEFORE, SELECT "N".
echo YOU CAN APPLY THEM LATER IN THE POST-INSTALL FOLDER.
choice /c yn /n /m "Do you want to select an experimental Win32? Y/N: "
if 0 EQU 1 goto {jrkc}
if 0 EQU 2 goto {jqrs}

:{jqrs}
echo Applying 26 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "26" /f
goto {pbag2}
:{jrkc}
echo.
echo Select any Win32 Priority
echo. 
echo 1. fffff311
echo 2. 26666475
echo 3. 1FFFFFE62
set /p w32sel=:

if  EQU 1 goto {sssss311}
if  EQU 2 goto {26666475}
if  EQU 3 goto {1SSSSSR62}

:{sssss311}
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "4294963985" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "4294963985" /f
goto {pbag2}
:{26666475}
echo Applying 26666475 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_QWORD /d "644244597" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_QWORD /d "644244597" /f
goto {pbag2}
:{1SSSSSR62}
echo Applying 1FFFFFE62 Hex Win32.
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "536870498" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "536870498" /f
goto {pbag2}



::Configs basicas
:{pbag2}

::Deshabilitar algunos servicios
cls
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LxpSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WManSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SamSs" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Beep" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\peauth" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wcifs" /v "Start" /t REG_DWORD /d "3" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d "4" /f
cls
choice /c yn /n /m "Do you use Windows Firewall? Y/N: "
IF 0 EQU 1 goto {jvsv}
IF 0 EQU 2 goto {absverjnyy}

:{absverjnyy}
echo.
echo Removing Firewall
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d "4" /f
goto {jvsv}

:{jvsv}
echo.
choice /c yn /n /m "Do you use Wi-Fi? Y/N: "
IF 0 EQU 1 goto {qbar}
IF 0 EQU 2 goto {abjvsv}

:{abjvsv}
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WwanSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Wcmsvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d "4" /f

:{qbar}
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /V "DisableSecuritySettingsCheck" /T "REG_DWORD" /D "00000001" /F
cls
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\mkScript.bat /start
echo.
echo Please wait...
C:\Windows\Temp\NSudo.exe -U:C -ShowWindowMode:Hide C:\Windows\Temp\PostScript.bat /start
del /F /Q "C:\Windows\Temp\dmvt.bat"
del /F /Q "C:\Windows\Temp\dmv.exe"
shutdown -r -f -t 7 -c "Please wait until your PC restarts..."
exit


:{VfNqzva}
Reg.exe query "HKU\S-1-5-19\Environment"
If Not 0 EQU 0 (
 cls 
Necesitas permisos de administrador para continuar ... 
 Pause 
