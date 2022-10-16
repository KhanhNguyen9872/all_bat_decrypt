title Win10 Debloat by Optimize Tweaksecho 
color cecho 
echo 
sc stop DiagTrackecho 
sc stop diagnosticshub.standardcollector.serviceecho 
sc stop dmwappushserviceecho 
sc stop WMPNetworkSvcecho 
sc stop WSearchecho 
sc config DiagTrack start= disabledecho 
sc config diagnosticshub.standardcollector.service start= disabledecho 
sc config dmwappushservice start= disabledecho 
sc config WMPNetworkSvc start= disabledecho 
sc config WSearch start= disabledecho 
clsecho 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disableecho 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disableecho 
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disableecho 
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disableecho 
schtasks /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disableecho 
clsecho 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /fecho 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /fecho 
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /fecho 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /fecho 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /fecho 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /fecho 
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /fecho 
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /fecho 
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /fecho 
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /fecho 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /fecho 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /fecho 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /fecho 
clsecho 
PowerShell -Command "Get-AppxPackage *3DBuilder* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Getstarted* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *WindowsCamera* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *bing* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *OneNote* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *people* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *WindowsPhone* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *photos* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *solit* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *WindowsSoundRecorder* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *zune* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Sway* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *CommsPhone* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Facebook* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Twitter* | Remove-AppxPackage"echo 
PowerShell -Command "Get-AppxPackage *Drawboard PDF* | Remove-AppxPackage"echo 
clsecho 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /fecho 
start /wait "" "%ﺖﮕ ﺼﭫﮕﺖﯤﮱﮢ ﮢﮱ ﺼﺖﺖتتﯔﺹﯔﺖﮱ ﯔﯤﮕﮢﺼﺼكﮚﺼﺼﭫﺹﮱكﭫﺹﮱﻁﻁﺹﯤﭫﺹﯔﭫﭫﮢﺖﺼ ﯔﯤﮕﻁﯤﮱﮚﮚﭲﺼﺹﺖﭫﯤﯤﮢﺖﺼﮚﮢﺼﺼ%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALLecho 
clsecho 
start /wait TASKKILL /F /IM explorer.exeecho 
start explorer.exeecho 
start https://discord.gg/RJwgeqRfv3echo 
exit
