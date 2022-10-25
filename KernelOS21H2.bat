@echo off
title KernelOS Script
color a
taskkill /f /im explorer.exe
powershell "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
set this=-------------------------------------------------------------------------------- & echo                                Welcome to KernelOS       				       & echo -------------------------------------------------------------------------------- & echo OS: Windows 10 21H2 & echo Creation Date: 10/31/2022
cls
echo 

::Importar powerplan
echo.
echo Importing KernelOS powerplan.

:{arkgcbj}
cls
echo 
echo.
echo Installing OpenShell y 7zip...
echo Please Wait...

::Eliminar cosas inutiles
cls
echo 
echo.
echo Deleting useless files...
powershell.exe "Get-AppxPackage -AllUsers *WindowsStore* | Remove-AppxPackage"
del /F /Q "C:\KernelOS-Modules\oss.exe"
del /F /Q "C:\KernelOS-Modules\7zip.exe"
del /F /Q "C:\KernelOS-Modules\KernelOS Performance v6.pow"
del /F /Q "C:\KernelOS-Modules\KernelOS Performance v6 IDLE ON.pow"

::Configurando 7zip
cls
echo 
echo.
echo Setting up 7zip...
start /b /wait "" "C:\KernelOS-Modules\7zipc.bat"

::Instalar DirectX...
cls
echo 
echo.
echo Installing DirectX.
start /wait C:\KernelOS-Modules\DirectX\DXSETUP.exe /silent
echo Installation complete.

::Instalar Visuals
cls
echo 
echo.
echo Installing Microsoft Visual Runtimes...
echo 2005...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2005_x86.exe /q
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2005_x64.exe /q

echo 2008...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2008_x86.exe /qb
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2008_x64.exe /qb

echo 2010...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2010_x86.exe /passive /norestart
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2010_x64.exe /passive /norestart

echo 2012...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2012_x86.exe /passive /norestart
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2012_x64.exe /passive /norestart

echo 2013...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2013_x86.exe /passive /norestart
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2013_x64.exe /passive /norestart

echo 2015, 2017 & 2019 & 2022...
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait C:\KernelOS-Modules\VisualAIO\vcredist2015_2017_2019_2022_x64.exe /passive /norestart
echo Installation completed successfully.

::BCDEDIT SETTINGS
cls
echo 
echo.
echo Tweaking BCDedit...
bcdedit /timeout 10
bcdedit /set useplatformtick Yes
bcdedit /set disabledynamictick Yes
bcdedit /set bootmenupolicy Legacy
bcdedit /set quietboot On
bcdedit /set x2apicpolicy Disable
bcdedit /set nx OptIn

::Configurar Device Manager
::Nirsoft Software
cls
echo 
echo.
echo Setting up Device Manager...
dmv /disable "System Speaker"
dmv /disable "System Timer"
dmv /disable "High precision event timer"
dmv /disable "UMBus Root Bus Enumerator"
dmv /disable "Programmable Interrupt Controller"
dmv /disable "Composite Bus Enumerator"
dmv /disable "Numeric Data Processor"
dmv /disable "PCI Memory Controller"
dmv /disable "PCI Simple Communications Controller"
dmv /disable "SM Bus Controller"
dmv /disable "PCI Data Acquisition and Signal Processing Controller"
dmv /disable "Base System Device"

::Nagle Algorithm
cls
echo 
echo.
echo Disabling Nagle Algorithm
for /f %i in ('wmic path win32_networkadapter get GUID | findstr "{"') do (
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
	reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
    reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
)
echo Ok...

:{qbar}
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "0000000000" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /V "DisableSecuritySettingsCheck" /T "REG_DWORD" /D "00000001" /F
cls
echo 
echo.
echo Please Wait...
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicrdv" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicshutdown" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmictimesync" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvmsession" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvss" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmcompute" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\pla" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gcs" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DialogBlockingService" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RmSvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GraphicsPerfSvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\smphost" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sppsvc" /v "Start" /t REG_DWORD /d "3" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BluetoothUserService" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RFCOMM" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthEnum" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthHFEnum" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidBth" /v "Start" /t REG_DWORD /d "4" /f
PowerRun.exe /SW:0 Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d "4" /f
if exist "C:\Program Files (x86)\Microsoft\Edge\Application" (
    for /f "delims=" %a in ('where /r "C:\Program Files (x86)\Microsoft\Edge\Application" *setup.exe*') do (
        if exist "%a" (
            "%a" --uninstall --system-level --verbose-logging --force-uninstall
        )
    )
)
:: Eliminar TextInputHost
PowerRun.exe /SW:0 Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TextInputHost.exe" /v Debugger /d "C:\Windows\system32\systray.exe" /f
PowerRun.exe /SW:0 taskkill.exe /im "TextInputHost.exe" /t /f
PowerRun.exe /SW:0 Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WindowsInternal.ComposableShell.Experiences.TextInput.InputApp.exe" /v Debugger /d "C:\Windows\system32\systray.exe" /f
PowerRun.exe /SW:0 taskkill.exe /im "WindowsInternal.ComposableShell.Experiences.TextInput.InputApp.exe" /t /f 
PowerRun.exe /SW:0 Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WindowsInternal.ComposableShell.Experiences.TextInput.InputApp.exe" /v Debugger /f
:: Fin TextInputHost
shutdown -r -f -t 7 -c "Please wait until your PC restarts..."
exit
