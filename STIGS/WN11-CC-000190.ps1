<#
.SYNOPSIS
    Applies Windows Explorer policy registry settings to disable Active Desktop and configure AutoRun behavior.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000190

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    1. Right-click PowerShell and select “Run as Administrator”.
    2. Run the script:
         PS> .\Set-ExplorerPolicies.ps1
    3. Verify results:
         PS> Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000190).ps1 

  
#>

# Define the registry path
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# Ensure the registry key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry values
Set-ItemProperty -Path $RegPath -Name "ForceActiveDesktopOn" -Type DWord -Value 0
Set-ItemProperty -Path $RegPath -Name "NoActiveDesktop" -Type DWord -Value 1
Set-ItemProperty -Path $RegPath -Name "NoActiveDesktopChanges" -Type DWord -Value 1
Set-ItemProperty -Path $RegPath -Name "NoDriveTypeAutoRun" -Type DWord -Value 0x255  # 0x255 = 597 decimal

# Confirm the applied settings
Get-ItemProperty -Path $RegPath | Select-Object ForceActiveDesktopOn, NoActiveDesktop, NoActiveDesktopChanges, NoDriveTypeAutoRun
