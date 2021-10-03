if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
	[Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You have to run this Script with elevated privileges"
    Write-Host "Press any key to exit the script"
    read-host
	exit 0
}

Get-ChildItem $env:Public\Desktop\*.lnk | ForEach-Object { Remove-Item $_ }
$ErrorActionPreference = 'SilentlyContinue'
Get-ChildItem $env:Public\Bureaublad\*.lnk | ForEach-Object { Remove-Item $_ }
Remove-Item C:\Users\$env:UserName\Desktop\*lnk –Force 
Remove-Item C:\Users\$env:UserName\Bureaublad\*lnk –Force 
Remove-Item C:\Users\$env:UserName\OneDrive\Desktop\*lnk –Force 
Remove-Item C:\Users\$env:UserName\OneDrive\Bureaublad\*lnk –Force
$ErrorActionPreference = 'Continue'


stop-process -name explorer -force


#clean up
cleanmgr /tuneup:1
C:\Windows\system32\cmd.exe /c Cleanmgr /sagerun:65535
c:\windows\SYSTEM32\cleanmgr.exe /c






# Requires administrator rights
# Note: This script is mainly intended to use with systems with SSD drives, and is not particularly well suitable for systems with "traditional" HDD drives (with rotating disks).
# Note: The computer will be automatically rebooted at the end of this script (the first Step 5)
$path = $env:temp
$empty_line = ""

# Check if the PowerShell session is elevated (has been run as an administrator)
# Credit: alejandro5042: "How to run exe with/without elevated privileges from PowerShell" http://stackoverflow.com/questions/29266622/how-to-run-exe-with-without-elevated-privileges-from-powershell?rq=1
If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator") -eq $false) {
    $empty_line | Out-String
    Write-Warning "It seems that this script is run in a 'normal' PowerShell window."
    $empty_line | Out-String
    Write-Verbose "Please consider running this script in an elevated (administrator-level) PowerShell window." -verbose
    $empty_line | Out-String
    $admin_text = "For performing system altering procedures, such as removing scheduled tasks, disabling services or writing the registry the elevated rights are mandatory. An elevated PowerShell session can, for example, be initiated by starting PowerShell with the 'run as an administrator' option."
    Write-Output $admin_text
    $empty_line | Out-String
    "Exiting without making any changes to the system." | Out-String
    Return ""
} Else {
    $continue = $true
} # else

# Step 1
# Disable the scheduled run inside the Disk Defragmenter (DFRGUI) options

# Step 2
# Write the original Windows scheduled tasks to a CSV-file and remove the scheduled defragmentation task
$empty_line | Out-String
"Step 2: Writing the original Windows scheduled tasks to a CSV-file and removing the scheduled defragmentation task..." | Out-String
$tasks = SCHTASKS /Query /TN "Microsoft\Windows\" /FO csv | ConvertFrom-Csv -Header "TaskName","NextRunTime","Status" | Where-Object { $_.Status -ne "" } | sort TaskName
$tasks | Export-Csv "$path\scheduled_tasks.csv" -Delimiter ';' -NoTypeInformation -Encoding UTF8
$query = $tasks | Where-Object { $_.TaskName -like "*Microsoft\Windows\Defrag\ScheduledDefrag*" }

    If ($query -eq $null) {
        "Did not find the scheduled defragmentation task 'Microsoft\Windows\Defrag\ScheduledDefrag'."
    } Else {
        Invoke-Expression 'SCHTASKS /Delete /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /F'
    } # else

# Step 3
# Disable the Disk Defragmenter service via regedit
$empty_line | Out-String
"Step 3: Disabling the Disk Defragmenter service via regedit..." | Out-String
Invoke-Expression 'REG add "HKLM\SYSTEM\CurrentControlSet\services\defragsvc" /v Start /t REG_DWORD /d 4 /f'

# Step 4
# Edit the registry (add the following two registry keys to disable disk defragmentation feature and auto-layout)
# Note: Please see below (at the next Step 4) for furher information about these commands (REG add /?) and keys
$empty_line | Out-String
"Step 4: Adding two registry keys to disable the disk defragmentation feature and auto-layout..." | Out-String
Invoke-Expression 'REG add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v Enable /t REG_SZ /d N /f'
Invoke-Expression 'REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" /v EnableAutoLayout /t REG_DWORD /d 0 /f'





# Reboot the computer
$empty_line | Out-String
Write-Host "Press any key to restart the computer..." -ForegroundColor Black -BackgroundColor White
$key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host "Restarting..."
Restart-Computer
