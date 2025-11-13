<#
.SYNOPSIS
    This PowerShell script ensures that the Microsoft consumer experiences is turned off to help prevent the unwanted installation of suggested applications.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000197

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
Run this script to disable Windows consumer features such as automatic installation of suggested or sponsored apps.
    - Must be run as Administrator.
    - Compatible with Windows 11 PowerShell (v5.1 or higher).
    - Creates the key path if it does not already exist.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000197).ps1 

  
#>

# Create the registry key if it doesn't exist
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null

# Set the DisableConsumerFeatures value to 1 (DWORD)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" `
    -Name "DisableConsumerFeatures" `
    -Type DWord `
    -Value 1

# Optional: Verify that the value was applied
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" | 
    Select-Object DisableConsumerFeatures
