<#
.SYNOPSIS
    Disables the Windows Ink Workspace by setting the registry key AllowWindowsInkWorkspace to 0.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000385

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
1. Open PowerShell **as Administrator**.
2. Save this script as Disable-WindowsInkWorkspace.ps1
3. Run the script:
    .\Disable-WindowsInkWorkspace.ps1
4. Verify the registry change in:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000385).ps1 

  
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"

# Create the key if it does not exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $regPath -Name "AllowWindowsInkWorkspace" -PropertyType DWord -Value 0 -Force

Write-Output "Registry key updated successfully."
