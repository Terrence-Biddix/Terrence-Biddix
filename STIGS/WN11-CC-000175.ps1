<#
.SYNOPSIS
   Sets the Windows AppCompat policy to disable inventory by creating or modifying the registry key 'DisableInventory' under
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat'.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000175

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    1. Open PowerShell **as Administrator**.
    2. Copy the script into a `.ps1` file, for example: Set-DisableInventory.ps1
    3. Run the script:
       ```powershell
       .\Set-DisableInventory.ps1
       ```
    4. The script will:
       - Check if the registry path `HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat` exists, and create it if it doesn't.
       - Set the DWORD value `DisableInventory` to `1`.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000175).ps1 

  
#>

# Define the registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$ValueName = "DisableInventory"
$ValueData = 1

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the DWORD value
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -Type DWord

# Optional: output the result
Write-Output "Registry key '$ValueName' set to $ValueData at $RegPath"
