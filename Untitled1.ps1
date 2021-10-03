cls

#Set ExecutionPolicy
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

#Install Choco
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Installations:
#choco install googlechrome
#choco install firefox
#choco install vlc
#choco install git.install
#choco install python
#choco install winrar
#choco install malwarebytes
#choco install nodejs.install
#choco install ccleaner
#choco install microsoft-teams.install
#choco install teamviewer
#choco install filezilla
#choco install vscode.install
#choco install atom
#choco install virtualbox
#choco install microsoft-windows-terminal
#choco install spotify
choco install tor-browser
choco install rufus
#version
#choco install jdk11
choco install anaconda3
choco install discord.install
choco install jetbrainstoolbox
choco install javaruntime
choco install advanced-ip-scanner
choco install gitkraken
choco install droidcamclient
choco install garmin-express
choco install laragon.install
choco install minecraft
choco install protonvpn
choco install recuva
choco install speedtest

#nog meer doen?
choco install wsl-ubuntu-1804

#choco install scenebuilder9

choco install protonvpn


#todo: kaspersky


#--------------------------------


#Personalization and colours
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'SystemUsesLightTheme' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -value '0'

#todo: accent color?

#Turn off Cortana
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Cortana
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Cortana' -Name 'IsAvailable' -value '0'


#Options Explorer
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSuperHidden' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideDrivesWithNoMedia' -value '1'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value '0'

Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowCortanaButton' -value '0'
Set-Itemproperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -value '1'


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
$value = "01,00,00,00,02,00,00,00"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "DWord"

#details container
<# doesn't work yet TODO
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer"
$Name = "DetailsContainer"
$value = "1"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "Binary"
$registryPath = "Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer"
$Name = "DetailsContainerSizer"
$value = "15,01,00,00,01,00,00,00,00,00,00,00,6d,02,00,00"
Set-ItemProperty -Path $registryPath -Name $Name -Value $value -Type "Binary"
#>

stop-process -name explorer -force
