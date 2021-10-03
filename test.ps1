if ((Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer') -eq $false){
    New-Item 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Force | New-ItemProperty -Name HideRecentlyAddedApps -Value 0 -Force | Out-Null
} else {
    Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'HideRecentlyAddedApps' -value '0'
}

stop-process -name explorer -force
