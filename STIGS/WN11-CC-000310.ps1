<#
.SYNOPSIS
    Disables Windows Installer elevated privileges and user control.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000310

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    1. Open PowerShell as Administrator.
    2. Copy this script into a `.ps1` file, e.g., `Disable-InstallerElevated.ps1`.
    3. Run the script:
       .\Disable-InstallerElevated.ps1
    4. Verify the changes:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer" | 
       Select-Object AlwaysInstallElevated, EnableUserControl
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000310).ps1 

  
#>

# Ensure the registry path exists
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry values
New-ItemProperty -Path $RegPath -Name "AlwaysInstallElevated" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $RegPath -Name "EnableUserControl" -PropertyType DWord -Value 0 -Force | Out-Null

# Confirm the values
Get-ItemProperty -Path $RegPath | Select-Object AlwaysInstallElevated, EnableUserControl
