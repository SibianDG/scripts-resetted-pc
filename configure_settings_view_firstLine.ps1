cls
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You have to run this Script with elevated privileges"
    Write-Host "Press any key to exit the script"
    read-host
	exit 0
}

#Set ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned



#Personalization and colours
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'SystemUsesLightTheme' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -value '0'

#todo: accent color?

#Turn off Cortana
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Cortana' -Name 'IsAvailable' -value '0'
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage


#Options Explorer
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideDrivesWithNoMedia' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value '0'

Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowCortanaButton' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -value '1'

#start menu
if ((Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer') -eq $false){
    New-Item 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Force | New-ItemProperty -Name HideRecentlyAddedApps -Value 1 -Force | Out-Null
} else {
    Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -value '1'
    Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -value '1'
    Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -value '0'
}

Set-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SystemPaneSuggestionsEnabled' -value '0' -Type "DWord"

#LaunchTo
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "LaunchTo2"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"


#"Show recently opened items in Jump Lists on Start or the taskbar" 
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "Start_TrackDocs"
$value = "0"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"


#Quick access
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
$Name = "ShowRecent"
$value = "0"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"
$Name = "ShowFrequent"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"

#checkboxes
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "AutoCheckSelect"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"

#nav-pane
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "NavPaneExpandToCurrentFolder"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "NavPaneShowAllCloudStates"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$Name = "NavPaneShowAllFolders"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"

#show libraries
$registryPath = "HKCU:\SOFTWARE\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"
$Name = "System.IsPinnedToNameSpaceTree"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"

#details container
<# doesn't work yet TODO
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer"
$Name = "DetailsContainer"
$value = "01,00,00,00,02,00,00,00"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "Binary"
$registryPath = "Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer"
$Name = "DetailsContainerSizer"
$value = "15,01,00,00,01,00,00,00,00,00,00,00,6d,02,00,00"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "Binary"
#>

#Windows Update

<#$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$Name = "AllowMUUpdateService "
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"
#>

#mouse settings
$registryPath = "HKCU:\Control Panel\Mouse"
Set-ItemProperty -Path $registryPath -Name "MouseSensitivity" -Value "12" -Type "String"
Set-ItemProperty -Path $registryPath -Name "MouseSpeed" -Value "1" -Type "String"
Set-ItemProperty -Path $registryPath -Name "MouseThreshold1" -Value "6" -Type "String"
Set-ItemProperty -Path $registryPath -Name "MouseThreshold2" -Value "10" -Type "String"



#start folders
$itemsToDisplay = @("explorer", "settings", "documents", "downloads", "music", "pictures", "videos", "network", "personal")
$key = Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*windows.data.unifiedtile.startglobalproperties\Current"
$data = $key.Data[0..19] -Join ","
If ($itemsToDisplay.Length -gt 0) {
    $data += ",203,50,10,$($itemsToDisplay.Length)"
    If ($itemsToDisplay -contains "explorer") {
        $data += ",5,188,201,168,164,1,36,140,172,3,68,137,133,1,102,160,129,186,203,189,215,168,164,130,1,0"
    }
    If ($itemsToDisplay -contains "settings") {
        $data += ",5,134,145,204,147,5,36,170,163,1,68,195,132,1,102,159,247,157,177,135,203,209,172,212,1,0"
    }
    If ($itemsToDisplay -contains "documents") {
        $data += ",5,206,171,211,233,2,36,218,244,3,68,195,138,1,102,130,229,139,177,174,253,253,187,60,0"
    }
    If ($itemsToDisplay -contains "downloads") {
        $data += ",5,175,230,158,155,14,36,222,147,2,68,213,134,1,102,191,157,135,155,191,143,198,212,55,0"
    }
    If ($itemsToDisplay -contains "music") {
        $data += ",5,160,140,172,128,11,36,209,254,1,68,178,152,1,102,170,189,208,225,204,234,223,185,21,0"
    }
    If ($itemsToDisplay -contains "pictures") {
        $data += ",5,160,143,252,193,3,36,138,208,3,68,128,153,1,102,176,181,153,220,205,176,151,222,77,0"
    }
    If ($itemsToDisplay -contains "videos") {
        $data += ",5,197,203,206,149,4,36,134,251,1,68,244,133,1,102,128,201,206,212,175,217,158,196,181,1,0"
    }
    If ($itemsToDisplay -contains "network") {
        $data += ",5,196,130,214,243,15,36,141,16,68,174,133,1,102,139,181,211,233,254,210,237,177,148,1,0"
    }
    If ($itemsToDisplay -contains "personal") {
        $data += ",5,202,224,246,165,7,36,202,242,3,68,232,158,1,102,139,173,143,194,249,160,135,212,188,1,0"
    }
}
$data += ",194,60,1,194,70,1,197,90,1,0"
Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $data.Split(",")

#news and Intressts
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds"
$Name = "ShellFeedsTaskbarViewMode"
$value = "2"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value

#copies the hosts file
Copy-Item -Path $PWD\extraFiles\hosts -Destination C:\Windows\System32\drivers\etc

Write "Enable extra updates"
Write "Show location of pointer when I press the CTRL key"
stop-process -name explorer -force

sysdm.cpl
