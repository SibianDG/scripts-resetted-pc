cls

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You have to run this Script with elevated privileges"
    Write-Host "Press any key to exit the script"
    read-host
	exit 0
}

$Desktop = Read-Host -Prompt 'Desktop? Y/N'
$Desktop = $Desktop.ToUpper()

#Install Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Installations:
choco install -y googlechrome
choco install -y firefox
choco install -y vlc
choco install -y git.install
choco install -y python
choco install -y winrar
choco install -y malwarebytes
choco install -y nodejs.install
choco install -y ccleaner
choco install -y microsoft-teams.install
choco install -y teamviewer
choco install -y filezilla
choco install -y vscode.install
choco install -y atom
choco install -y virtualbox
choco install -y microsoft-windows-terminal
choco install -y tor-browser
choco install -y rufus
choco install -y oraclejdk
choco install -y anaconda3
choco install -y discord.install
choco install -y jetbrainstoolbox
choco install -y javaruntime
choco install -y advanced-ip-scanner
choco install -y gitkraken
choco install -y droidcamclient
choco install -y garmin-express
choco install -y laragon.install
choco install -y protonvpn
choco install -y recuva
choco install -y speedtest
choco install -y signal

if ($Desktop.ToUpper() -eq "Y") {
    choco install -y evoluentmousemanager
    choco install -y minecraft
	choco install -y icue
}


#nog meer doen?
#choco install wsl-ubuntu-1804
#choco install spotify #not in Windows11

