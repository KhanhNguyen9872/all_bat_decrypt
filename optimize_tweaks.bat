:: Optimize Tweaks - https://discord.gg/RJwgeqRfv3
CLS
@ECHO OFF
color c
:HOME
cls
ECHO  *** Network Optimizator ***
ECHO.
ECHO  This utility is designed to optimize the internet
ECHO  Made by: Optimize Tweaks
ECHO.
ECHO  ------------------------------------------
ECHO  Type "1" To disable the Nagle algorithm
ECHO  Type "2" to configure Netsh
ECHO  Type "3" to configure the registry
ECHO  Type "4" To reset the Internet
ECHO  ------------------------------------------
SET /P choice1= Type 1,2,3,4 and press ENTER:   
IF /I "%choice1%"=="1" GOTO AlgoritmNagle
IF /I "%choice1%"=="2" GOTO Netsh
IF /I "%choice1%"=="3" GOTO Registry
IF /I "%choice1%"=="4" GOTO Reset

:AlgoritmNagle
CLS
for /f "usebackq" %i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`) do (
Reg.exe add %i /v "TcpAckFrequency" /d "1" /t REG_DWORD /f
Reg.exe add %i /v "TCPNoDelay" /d "1" /t REG_DWORD /f
)
cls
ECHO  * Nagle algorithm is disabled *
pause
GOTO HOME

:Netsh
CLS
netsh winsock reset catalog 
netsh int ip reset c:resetlog.txt 
netsh int ip reset C:\tcplog.txt
netsh int tcp set heuristics disabled
netsh int tcp set supplemental Internet congestionprovider=ctcp
netsh int tcp set global rsc=disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global initialRto=2100
cls
ECHO  * Netsh settings changed *
ECHO.
@PAUSE
GOTO HOME

:Registry
CLS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "10" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "1" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "30" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f
cls
ECHO  * Registry settings changed *
pause
GOTO HOME

:Reset
CLS 
for /f "usebackq" %i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`) do (
Reg.exe delete %i /v "TcpAckFrequency" /f
Reg.exe delete %i /v "TCPNoDelay" /f
Reg.exe delete %i /v "TCPDelAckTicks" /f
Reg.exe delete %i /v "MTU" /f
Reg.exe delete %i /v "MSS" /f
Reg.exe delete %i /v "TcpWindowSize" /f
Reg.exe delete %i /v "GlobalMaxTcpWindowSize" /f
Reg.exe delete %i /v "Tcp1323Opts" /f
)
for /f "usebackq" %i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}`) do (
Reg.exe delete %i /v "ScanWhenAssociated" /f
(
netsh int tcp set global autotuninglevel=default
netsh int tcp set global chimney=default
netsh int tcp set global dca=default
netsh int tcp set global netdma=default
netsh int tcp set global congestionprovider=default
netsh int tcp set global ecncapability=default
netsh int tcp set heuristics default
netsh int tcp set global rss=default
netsh int tcp set global fastopen=default
netsh int tcp set global timestamps=default
netsh int tcp set global nonsackrttresiliency=default
netsh int tcp set global rsc=default
netsh int tcp set global maxsynretransmissions=2
netsh int tcp set global initialRto=3000
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\CACHE" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0001" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0002" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0003" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0004" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0005" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0006" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0007" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Browser" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Class\Net" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Class\NetTrans" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Psched" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "Class" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "2000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "500" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "499" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "2001" /f
Reg.exe add "HKLM\System\CurrentControlSet\Services\NDIS\Parameters" /f
Reg.exe add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_Server" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\CACHE" /v "Persistent" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "IgnoreOSNameValidation" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_Server" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control" /v "IRPStackSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0000" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0001" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0002" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0003" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0004" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0005" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0006" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4q36r972-r325-11pr-osp1-08002or10318}\0007" /v "ScanWhenAssociated" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "BufferMultiplier" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DynamicBacklogGrowthDelta" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "EnableDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "KeepAliveInterval" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "MaximumDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "MinimumDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "NonBlockingSendSpecialBuffering" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Class\Net" /v "MaxMSS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Class\Net" /v "MaxMTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Class\NetTrans" /v "MaxMSS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Class\NetTrans" /v "MaxMTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "CacheHashTableBucketSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "CacheHashTableSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "MaxCacheEntryTtlLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "MaxCacheTtl" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "MaxNegativeCacheTtl" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "MaxSOACacheEntryTtlLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "MaximumUdpPacketSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "NegativeCacheTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "NegativeSOACacheTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "NetFailureCacheTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "ServerPriorityTimeLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\DNScache\Parameters" /v "ServiceDllUnloadOnStop" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "DisablePagingExecutive" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "DisableStrictNameChecking" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "MaxCmds" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "MaxMpxCt" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "MaxWorkItems" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SizReqBuf" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableLargeMTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "EnableSecuritySignature" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "KeepConn" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "UseLockReadUnlock" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "UtilizeNtCaching" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "BcastNameQueryCount" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "BcastQueryTimeout" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "CacheTimeout" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "EnableLMHOSTS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NameServerPort" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NameSrvQueryCount" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NameSrvQueryTimeout" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "SessionKeepAlive" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "Size/Small/Medium/Large" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "UseNewSmb" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Psched" /v "NonBestEffortLimit" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ArpCacheLife" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ArpCacheMinReferencedLife" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ArpCacheSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableLargeMTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableConnectionRateLimiting" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableDCA" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableDHCP" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableDeadGWDetect" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableMulticastForwarding" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableRSS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPA" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableWsd" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ForwardBroadcasts" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "ForwardBufferMemory" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "IRPStackSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveInterval" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveTime" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MSS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPer1_0Server" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPer1_Server" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxDupAcks" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxForwardBufferMemory" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxHashTableSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxMSS" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxMTU" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxNumForwardPackets" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaximumDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MinimumDynamicBacklog" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NumForwardPackets" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NumTcbTablePartitions" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "QualifyingDestinationThreshold" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SizReqBuf" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPDelAckTicks" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPInitialRtt" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPNoDelay" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpCreateAndConnectTcbRateLimitDepth" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpFinWait2Delay" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxConnectRetransmissions" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDataRetransmissions" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpen" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxSendFree" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpNumConnections" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpUseRFC1122UrgentPointer" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TransmitWorker" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "UseZeroBroadcast" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /f
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /f
Reg.exe delete "HKLM\System\CurrentControlSet\Services\NDIS\Parameters" /v "MaxNumRssCpus" /f
Reg.exe delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /f
Reg.exe delete "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /f
netsh winsock reset catalog
netsh branchcache reset
netsh branchcache flush
netsh int ip reset
netsh int tcp reset
netsh int ipv4 reset reset.log
netsh int ipv6 reset reset.log 
ipconfig /release
ipconfig /renew
start https://discord.gg/RJwgeqRfv3   
ipconfig /flushdns  
cls
ECHO   * All internet settings reset *
ECHO.
@PAUSE
GOTO HOME

          :: [The program is made by Optimize Tweaks. Media - https://discord.gg/RJwgeqRfv3]
:: _______________________________________________
