Copy-Item ".\extraFiles\ubuntu_32px.png" -Destination "C:\Users\sibia\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState"

Copy-Item ".\extraFiles\terminal.json" -Destination "C:\Users\sibia\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

# uuidgen -> id voor Ubuntu

# Enable Ubuntu:

# dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart