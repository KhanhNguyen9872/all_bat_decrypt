@echo off
color fD
title Haha Custom Regedit Maker (v4.0)

call :2

set /p NAME=Regedit Name (Pick any name): 
echo.
:3
CLS
call :2
set /p MTU=MTU (Value + 28, Type find to find your optimal MTU): 
if /i ""=="find" (goto :MTU)
if /i "1" NEQ "0" (goto :3)
for /f "tokens=2* delims==" %a in (
  'wmic.exe nic where "NetConnectionStatus=2" get NetConnectionID /value'
) do set INTERFACE=%a
for /f "tokens=* delims= " %a in ("") do set INTERFACE=%a
for /l %a in (1,1,100) do if "!INTERFACE:~-1!"==" " set INTERFACE=!INTERFACE:~0,-1!
set /a MSS=-40
set MTU2=
set MSS2=
CLS

:4
call :2
set /p DLSPEED=Download Speed (Enter in Mbps without decimals): 
if /i "1" NEQ "0" (goto :4)
CLS

:5
call :2
set /p PING=Average Ping to Servers (Ping to servers that you play on): 
if /i "1" NEQ "0" (goto :6)
CLS

:6
call :2
set /p NUMPROC=CPU Core Amount (Type find to find your amount): 
if /i ""=="find" (
   for /f %a in ('echo 1') do (set NUMPROC=%a)
   goto :7
)
if /i "1" NEQ "0" (goto :6)
CLS

:7
call :2
set /p INFOTWS=Gaming or Normal (Enter Gaming to optimize kb/latency or Normal for internet speed/maximal throughput): 
if /i ""=="Gaming" (
   set LARGECACHE=0
   set SYSRES=0
   goto :8
)
if /i ""=="Normal" (
   set LARGECACHE=1
   set SYSRES=a
   goto :8
)
goto :7
CLS

:8
call :2
set /p CT=Connection Type (Enter Ethernet, Wireless, or find to find): 
if /i ""=="Ethernet" (set MAXCC=16&goto :9)
if /i ""=="Wireless" (set MAXCC=10&goto :9)
if /i ""=="find" (
set MAXCC=16
if /i ""=="Wi-Fi" (set MAXCC=10)
if /i ""=="Wireless Network Connection" (set MAXCC=10)
if /i ""=="Local Area Connection" (set MAXCC=16)
if /i ""=="Ethernet" (set MAXCC=16)
if /i ""=="Ethernet 2" (set MAXCC=16)
if /i ""=="Ethernet 3" (set MAXCC=16)
goto :9
)
goto :8
CLS

:9
call :2
set /p HTDC=Hit Detection Speed % (Number from 1 to 100, 1 being most delayed hits, and 100 being fastest hits): 
if /i "1" NEQ "0" (goto :9)
if /i  GTR 100 (goto :9)
if /i  LSS 1 (goto :9)
set /a HITSTEP1=100-
set /a HITSTEP2=*2
set /a HTDC=+64
if /i  GTR 255 (set HTDC=255)
if /i  LSS 64 (set HTDC=64)
goto :92
CLS

:92
call :2
set /p DELKB=Knockback Delayness Multiplier (Number from 1 to 10, 1 being fast knockback, and 10 being delayed knockback): 
if /i "1" NEQ "0" (goto :92)
if /i  GTR 10 (goto :92)
if /i  LSS 1 (goto :92)
goto :93
CLS
:93
call :2
set /p HSBOS=Low MTU / TTL - Faster Hits (Experimental: May Cause Internet Issues) (Type yes if you want or no if you don't): 
if /i ""=="yes" (
   set MTU2=450
   set MSS2=410
   set HTDC=20
   goto :94
) else (
set MTU2=
set MSS2=
)
if /i ""=="no" (
   goto :94
)
goto :93
CLS
:94
call :2
set /p FPS=FPS Boost (Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :95)
if /i ""=="no" (goto :95)
goto :94
CLS
:95
call :2
set /p NETSH=Netsh Settings (Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :96)
if /i ""=="no" (goto :96)
goto :95
CLS
:96
call :2
set /p MISPLACE=Connection Misplacer (Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :97)
if /i ""=="no" (goto :97)
goto :96
CLS
:97
call :2
set /p INTREG=Interface Regedit (Recommended - Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :98)
if /i ""=="no" (goto :98)
goto :97
CLS
:98
call :2
set /p MOUSEKEY=Mouse / Keyboard Tweaks (Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :99)
if /i ""=="no" (goto :99)
goto :98
CLS
:99
call :2
set /p PCTWEAK=PC Optimizer (Type yes if you want or no if you don't): 
if /i ""=="yes" (goto :100)
if /i ""=="no" (goto :100)
goto :99
CLS
:100
call :2
set /p IDELAYER=Internet Delayer / Extra Ping (Type yes if you want or no if you don't): 
if /i ""=="yes" (
   set TCPND=0
   set TCPACK=255
   set TCPACK2=ff
   set DELACKT=6
   goto :10
)
if /i ""=="no" (
   set TCPND=1
   set TCPACK=1
   set TCPACK2=1
   set DELACKT=0
   goto :10
)
goto :100
CLS
:10
call :2
CLS
echo Creating Regedit . . .
echo.
echo Please Wait . . .


:: =======================
:: Calculate Custom Values
:: =======================
set DLSPEED=000

for /f %a in ('powershell 65535/') do (set WINDOWSTEP=%a)
set "NTR="
for /f "tokens=1,2 delims=." %a  in ("") do (
  set FP=%a
)

for /f %a in ('powershell *') do (set BDP=%a)
for /f %a in ('powershell *') do (set BDPSTEP=%a)
for /f %a in ('powershell /8') do (set BDPSTEP2=%a)
set OLDBDP=
set UNSCALED=
set /a SAFEZONE=0
CLS
:11
CLS
if /i  LSS  (
   for /f %a in ('powershell *2') do (set BDP=%a)
   if /i "" GEQ "20" (
      set /a BDP=
      goto :12
   )
   set /a SAFEZONE+=1
   goto :11
)
CLS
:12
CLS
for /f %a in ('powershell *') do (set BDP=%a)
:: ==============
:: Decimal to HEX
:: ==============
if /i ""=="yes" (
   set BDP=
)
set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set RWIN=

set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set MTUDONE=

set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set MSSDONE=

set /a TABLEPART=*4
set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set TABLEPART=

set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set MAXCONNECTIONS=

set "DEC="
set "DEC="
if not defined DEC goto :EOF
cmd /C exit 
set "HEX="
for /F "tokens=* delims=0" %Z in ("") do set "HEX=%Z"
if not defined HEX set "HEX=0"
set DEFTTL=

:: ===============
:: Network Regedit
:: ===============
CLS
:13
CLS
(
echo Windows Registry Editor Version 5.00
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
echo "DefaultTTL"=dword:
echo "DisableTaskOffload"=dword:00000001
echo "DisableLargeMtu"=dword:00000000
echo "EnableConnectionRateLimiting"=dword:00000000
echo "EnableDCA"=dword:00000001
echo "EnablePMTUBHDetect"=dword:00000000
echo "EnablePMTUDiscovery"=dword:00000001
echo "EnableRSS"=dword:00000001
echo "EnableTCPA"=dword:00000000
echo "EnableWsd"=dword:00000000
echo "GlobalMaxTcpWindowSize"=dword:
echo "MaxConnectionsPer1_0Server"=dword:
echo "MaxConnectionsPerServer"=dword:
echo "MaxFreeTcbs"=dword:0000ffff
echo "MaxHashTableSize"=dword:00010000
echo "MaxUserPort"=dword:0000fffe
echo "NumTcbTablePartitions"=dword:
echo "SackOpts"=dword:00000001
echo "SynAttackProtect"=dword:00000001
echo "Tcp1323Opts"=dword:00000001
echo "TcpCreateAndConnectTcbRateLimitDepth"=dword:00000000
echo "TcpMaxDataRetransmissions"=dword:00000003
echo "TcpMaxDupAcks"=dword:00000002
echo "TcpMaxSendFree"=dword:0000ffff
echo "TcpNumConnections"=dword:00fffffe
echo "TcpTimedWaitDelay"=dword:0000001e
echo "TcpFinWait2Delay"=dword:0000001e
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\QoS]
echo "Do not use NLA"="1"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters]
echo "TCPNoDelay"=dword:
echo "IgnoreOSNameValidation"=dword:00000001
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
echo "MaxConnectionsPerServer"=dword:
echo "MaxConnectionsPer1_0Server"=dword:
echo [HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
echo "MaxConnectionsPerServer"=dword:
echo "MaxConnectionsPer1_0Server"=dword:
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings]
echo "MaxConnectionsPerServer"=dword:
echo "MaxConnectionsPer1_0Server"=dword:
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
echo "NetworkThrottlingIndex"=dword:ffffffff
echo "SystemResponsiveness"=dword:
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider]
echo "LocalPriority"=dword:00000004
echo "HostsPriority"=dword:00000005
echo "DnsPriority"=dword:00000006
echo "NetbtPriority"=dword:00000007
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched]
echo "NonBestEffortLimit"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Psched]
echo "NonBestEffortLimit"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters]
echo "IRPStackSize"=dword:00000020
echo "SizReqBuf"=dword:00004410
echo "Size"=dword:00000003
echo "MaxWorkItems"=dword:00002000
echo "MaxMpxCt"=dword:00000800
echo "MaxCmds"=dword:00000800
echo "DisableStrictNameChecking"=dword:00000001
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters]
echo "MaxCmds"=dword:0000001e
echo "MaxThreads"=dword:0000001e
echo "MaxCollectionCount"=dword:00000020
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
echo "LargeSystemCache"=dword:
echo "IoPageLockLimit"=dword:000f0000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters]
echo "EnableDynamicBacklog"=dword:00000001	
echo "MinimumDynamicBacklog"=dword:000000c8
echo "MaximumDynamicBacklog"=dword:00004e20
echo "DynamicBacklogGrowthDelta"=dword:00000064
echo "KeepAliveInterval"=dword:00000001
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
echo "NegativeSOACacheTime"=dword:00000000
echo "NetFailureCacheTime"=dword:00000000
echo "MaxCacheEntryTtlLimit"=dword:00002a30
echo "MaxCacheTtl"=dword:00002a30
echo "MaxNegativeCacheTtl"=dword:00000000
CLS
:14
CLS
if /i ""=="no" (goto :15)

:: ===========
:: FPS Regedit
:: ===========
(
echo Windows Registry Editor Version 5.00
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
echo "ValueMin"=dword:00000000
echo "ValueMax"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
echo "ValueMax"=dword:00000000
echo "ValueMin"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
echo "ValueMax"=dword:00000000
echo "ValueMin"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
echo "HibernateEnabled"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
echo "HiberbootEnabled"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\893dee8e-2bef-41e0-89c6-b55d0929964c]
echo "ValueMax"=dword:00000064
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\893dee8e-2bef-41e0-89c6-b55d0929964c\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c]
echo "ValueMax"=dword:00000064
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler]
echo "VsyncIdleTimeout"=dword:00000000
echo [HKEY_CURRENT_USER\System\GameConfigStore]
echo "GameDVR_Enabled"=dword:00000000
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR]
echo "AppCaptureEnabled"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR]
echo "AllowgameDVR"=dword:00000000
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Intel\GMM]
echo "DedicatedSegmentSize"=dword:00000512
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
echo "Win32PrioritySeparation"=dword:00000026
echo "IRQ8Priority"=dword:00000001
echo "IRQ16Priority"=dword:00000002
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl]
echo "Win32PrioritySeparation"=dword:00000026
echo "IRQ8Priority"=dword:00000001
echo "IRQ16Priority"=dword:00000002
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
echo "EnablePrefetcher"=dword:00000000
echo "EnableSuperfetch"=dword:00000000
echo "EnableBoottrace"=dword:00000000
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
echo "NoLowDiskSpaceChecks"=dword:00000001
echo "LinkResolveIgnoreLinkInfo"=dword:00000001
echo "NoResolveSearch"=dword:00000001
echo "NoResolveTrack"=dword:00000001
echo "NoInternetOpenWith"=dword:00000001
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
echo "NtfsMftZoneReservation"=dword:00000001
echo "NTFSDisable8dot3NameCreation"=dword:00000001
echo "DontVerifyRandomDrivers"=dword:00000001
echo "NTFSDisableLastAccessUpdate"=dword:00000001
echo "ContigFileAllocSize"=dword:00000040
echo [HKEY_CURRENT_USER\Control Panel\Desktop]
echo "AutoEndTasks"="1"
echo "MenuShowDelay"="0"
echo "WaitToKillAppTimeout"="5000"
echo "WaitToKillServiceTimeout"="1000"
echo "HungAppTimeout"="4000"
echo "LowLevelHooksTimeout"="1000"
echo "ForegroundLockTimeout"="150000"
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Games]
echo "FpsAll"=dword:00000001
echo "GameFluidity"=dword:00000001
echo "FpsStatusGames"=dword:00000010
echo "FpsStatusGamesAll"=dword:00000004
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
echo "Affinity"=dword:00000000
echo "Background Only"="False"
echo "Clock Rate"=dword:00002710
echo "GPU Priority"=dword:00000008
echo "Priority"=dword:00000002
echo "Scheduling Category"="High"
echo "SFIO Priority"="High"
echo "Latency Sensitive"="True"
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency]
echo "Affinity"=dword:00000000
echo "Background Only"="False"
echo "Clock Rate"=dword:00002710
echo "GPU Priority"=dword:00000008
echo "Priority"=dword:00000002
echo "Scheduling Category"="High"
echo "SFIO Priority"="High"
echo "Latency Sensitive"="True"
echo [HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\BIOS]
echo "CPUPriority"=dword:00000001
echo "FastDRAM"=dword:00000001
echo "PCIConcur"=dword:00000001
echo "AGPConcur"=dword:00000001
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
echo "Max Cached Icons"="2000"
echo "AlwaysUnloadDLL"=dword:00000001
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AlwaysUnloadDLL]
echo "Default"=dword:00000001
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
echo "EnableBalloonTips"=dword:00000000
CLS
:15
CLS
if /i ""=="no" (goto :16)

:: ============
:: Netsh Tweaks
:: ============
(
echo @echo off
echo netsh int tcp set global autotuninglevel=normal
echo netsh int tcp set global chimney=enabled
echo netsh int tcp set global dca=enabled
echo netsh int tcp set global netdma=disabled
echo netsh int tcp set global congestionprovider=ctcp
echo netsh int tcp set global ecncapability=disabled
echo netsh int tcp set heuristics disabled
echo netsh int tcp set global rss=enabled
echo netsh int tcp set global fastopen=enabled
echo netsh int tcp set global nonsackrttresiliency=disabled
echo netsh int tcp set global rsc=enabled
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Nsi\{eb004a03-9b1a-11d4-9123-0050047759bc}\0" /v "0200" /t REG_BINARY /d "0000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000ff000000000000000000000000000000000000000000ff000000000000000000000000000000" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Nsi\{eb004a03-9b1a-11d4-9123-0050047759bc}\0" /v "1700" /t REG_BINARY /d "0000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000ff000000000000000000000000000000000000000000ff000000000000000000000000000000" /f
echo pause
CLS
:16
if /i ""=="no" (goto :17)

:: ====================
:: Connection Misplacer
:: ====================
set "line=for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)"
set "line2=for /f "tokens=3" %%a in ('sc queryex "Dnscache" ^| findstr "PID"') do (set pid=%%a)"
(
echo @echo off
echo (
echo sc config "BITS" start= auto
echo sc start "BITS"
echo !line!
echo ) >nul 2>&1
echo wmic process where ProcessId=%pid% CALL setpriority "idle"
echo (
echo sc config "Dnscache" start= demand
echo sc start "Dnscache"
echo !line2!
echo ) >nul 2>&1
echo wmic process where ProcessId=%pid% CALL setpriority "realtime"
echo wmic process where name="mqsvc.exe" CALL setpriority "high priority"
echo wmic process where name="mqtgsvc.exe" CALL setpriority "high priority"
echo wmic process where name="javaw.exe" CALL setpriority "realtime"
echo pause
CLS
:17
if /i ""=="no" (goto :18)

:: =================
:: Interface Regedit
:: =================
(
echo @echo off
echo for /f "usebackq" %%i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`) do (
echo Reg.exe add %%i /v "TcpAckFrequency" /d "" /t REG_DWORD /f
echo Reg.exe add %%i /v "TCPNoDelay" /d "" /t REG_DWORD /f
echo Reg.exe add %%i /v "TCPDelAckTicks" /d "" /t REG_DWORD /f
echo Reg.exe add %%i /v "MTU" /d "" /t REG_DWORD /f
echo Reg.exe add %%i /v "MSS" /d "" /t REG_DWORD /f
echo Reg.exe add %%i /v "TcpWindowSize" /d "" /t REG_DWORD /f
echo )
echo pause
CLS
:18
if /i ""=="no" (goto :19)

:: =======================
:: Mouse / Keyboard Tweaks
:: =======================
(
echo Windows Registry Editor Version 5.00
echo [HKEY_CURRENT_USER\Control Panel\Mouse]
echo "MouseSpeed"="0"
echo "MouseThreshold1"="0"
echo "MouseThreshold2"="0"
echo "MouseHoverTime"="100"
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
echo "AutoRepeatDelay"="1000"
echo "AutoRepeatRate"="500"
echo "BounceTime"="0"
echo "DelayBeforeAcceptance"="0"
echo "Flags"="122"
echo "Last BounceKey Setting"=dword:00000000
echo "Last Valid Delay"=dword:00000000
echo "Last Valid Repeat"=dword:00000000
echo "Last Valid Wait"=dword:000003e8
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
echo "Flags"="506"
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]
echo "Flags"="58"
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys]
echo "Flags"="38"
echo [HKEY_CURRENT_USER\Control Panel\Keyboard]
echo "InitialKeyboardIndicators"="0"
echo "KeyboardDelay"="0"
echo "KeyboardSpeed"="31"
CLS
:19
if /i ""=="no" (goto :20)

:: =================
:: PCOptimizer Tweak
:: =================
(
echo @echo off
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "421527552" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "8" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDll" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "512" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\wercplsupport" /v "start" /t REG_DWORD /d "4" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
echo Reg.exe add "HKLM\SOFTWARE\Policies\Skype\Phone" /v "DisableVersionCheck" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\Skype.com" /v "https" /t REG_DWORD /d "4" /f
echo Reg.exe add "HKU\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
echo Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "CPUPriority" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "FastDRAM" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d "3" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMemoryUsage" /t REG_DWORD /d "2" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "4000" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
echo Reg.exe add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_SZ /d "150000" /f
echo Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TimeBrokerSvc" /v "Start" /t REG_DWORD /d "4" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TimeBroker" /v "Start" /t REG_DWORD /d "4" /f
echo Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "CPUPriority" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\System\CurrentControlSet\Services\VxD\BIOS" /v "FastDRAM" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d "3" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsMemoryUsage" /t REG_DWORD /d "2" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "1298" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet002\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "1298" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
echo Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "BootId" /t REG_DWORD /d "38" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "BaseTime" /t REG_DWORD /d "489678465" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableBoottrace" /t REG_DWORD /d "0" /f
echo Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "SfTracingState" /t REG_DWORD /d "0" /f
echo pause
CLS
:20
cls
pause
exit

:MTU
for /f "tokens=2* delims==" %a in (
  'wmic.exe nic where "NetConnectionStatus=2" get NetConnectionID /value'
) do set INTERFACE=%a
for /f "tokens=* delims= " %a in ("") do set INTERFACE=%a
for /l %a in (1,1,100) do if "!INTERFACE:~-1!"==" " set INTERFACE=!INTERFACE:~0,-1!
set MTU=1500
set OUTPUT=""
CLS
:40
if 1 EQU 0 (
set OUTPUT=good
set /a MTU=MTU+1
goto :40
)
if 1 EQU 1 (
if /i ""=="good" (
set /a MTU=MTU-1+28
set /a MSS=MTU-40

.)
set OUTPUT=bad
set /a MTU=MTU-10
goto :40
)
goto :EOF
CLS
:2

echo.
echo                                                  HAHA REGISTERY MAKER V1     
echo.  
echo                                                   CODE  HAHA
echo.
