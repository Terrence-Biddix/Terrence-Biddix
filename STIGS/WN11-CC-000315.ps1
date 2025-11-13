<#
.SYNOPSIS
    This PowerShell script ensures that the Windows Installer feature “Always install with elevated privileges” is disabled.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2024-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Run this script as Administrator to disable "Always install with elevated privileges."

    Example syntax:
        PS C:\> .\__remediation_WN11-CC-000315.ps1
#>

# Disable "Always install with elevated privileges"
# STIG ID: WN11-CC-000315

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$Name = "AlwaysInstallElevated"
$Value = 0

# Ensure the registry path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Create or update the DWORD value
Set-ItemProperty -Path $RegPath -Name $Name -Value $Value -Type DWord

# Confirm the setting
Get-ItemProperty -Path $RegPath -Name $Name
