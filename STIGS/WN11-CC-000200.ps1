<#
.SYNOPSIS
   This PowerShell script sets the Windows Registry key to disable the "EnumerateAdministrators" feature under CredUI, which affects 
    how user accounts are enumerated on the login screen.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000200

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
        1. Open PowerShell as Administrator.
        2. Navigate to the folder containing the script.
        3. Execute the script:
           .\Set-CredUIEnumerateAdmins.ps1
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000200).ps1 

  
#>

# Define the registry path and property
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$propertyName = "EnumerateAdministrators"
$propertyValue = 0

# Check if the registry key exists, create it if it doesn't
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the DWORD value
New-ItemProperty -Path $regPath -Name $propertyName -PropertyType DWord -Value $propertyValue -Force

# Optional: verify it was set
Get-ItemProperty -Path $regPath | Select-Object $propertyName
