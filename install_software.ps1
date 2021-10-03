cls

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You have to run this Script with elevated privileges"
    Write-Host "Press any key to exit the script"
    read-host
	exit 0
}

#Install Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Installations:
choco install googlechrome
choco install firefox
choco install vlc
choco install git.install
choco install python
choco install winrar
choco install malwarebytes
choco install nodejs.install
choco install ccleaner
choco install microsoft-teams.install
choco install teamviewer
choco install filezilla
choco install vscode.install
choco install atom
choco install virtualbox
choco install microsoft-windows-terminal
choco install spotify
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