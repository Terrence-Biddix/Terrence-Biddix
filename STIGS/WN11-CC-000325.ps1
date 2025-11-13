<#
.SYNOPSIS
   Configures Windows 11 system policies and User Account Control (UAC) settings by creating/updating registry keys under HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System,
    including clipboard exception formats and startup task behavior.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000325

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    1. Open PowerShell as Administrator.
    2. Navigate to the folder containing Apply-WindowsPolicies.ps1.
    3. Execute the script:

        .\Apply-WindowsPolicies.ps1

    4. Upon completion, you will see:
        "Registry keys successfully applied."
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000325).ps1 

  
#>

# Ensure the script runs as Administrator
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "This script must be run as Administrator."
    exit
}

$basePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Create the main key if it doesn't exist
If (-Not (Test-Path $basePath)) {
    New-Item -Path $basePath -Force | Out-Null
}

# Set registry values
$regValues = @{
    "ConsentPromptBehaviorAdmin" = 5
    "ConsentPromptBehaviorEnhancedAdmin" = 1
    "ConsentPromptBehaviorUser" = 3
    "DSCAutomationHostEnabled" = 2
    "EnableCursorSuppression" = 1
    "EnableFullTrustStartupTasks" = 2
    "EnableInstallerDetection" = 1
    "EnableLUA" = 1
    "EnableSecureUIAPaths" = 1
    "EnableUIADesktopToggle" = 0
    "EnableUwpStartupTasks" = 2
    "EnableVirtualization" = 1
    "PromptOnSecureDesktop" = 1
    "SupportFullTrustStartupTasks" = 1
    "SupportUwpStartupTasks" = 1
    "TypeOfAdminApprovalMode" = 1
    "ValidateAdminCodeSignatures" = 0
    "dontdisplaylastusername" = 0
    "legalnoticecaption" = ""
    "legalnoticetext" = ""
    "scforceoption" = 0
    "shutdownwithoutlogon" = 1
    "undockwithoutlogon" = 1
    "DisableAutomaticRestartSignOn" = 1
}

# Apply the values
foreach ($name in $regValues.Keys) {
    $value = $regValues[$name]
    Set-ItemProperty -Path $basePath -Name $name -Value $value -Force
}

# Create subkeys
$subKeys = @(
    "Audit",
    "UIPI",
    "UIPI\Clipboard",
    "UIPI\Clipboard\ExceptionFormats"
)

foreach ($subKey in $subKeys) {
    $fullPath = Join-Path $basePath $subKey
    If (-Not (Test-Path $fullPath)) {
        New-Item -Path $fullPath -Force | Out-Null
    }
}

# Set Clipboard ExceptionFormats
$clipboardValues = @{
    "CF_BITMAP" = 2
    "CF_DIB" = 8
    "CF_DIBV5" = 17
    "CF_OEMTEXT" = 7
    "CF_PALETTE" = 9
    "CF_TEXT" = 1
    "CF_UNICODETEXT" = 13
}

$clipboardPath = Join-Path $basePath "UIPI\Clipboard\ExceptionFormats"

foreach ($name in $clipboardValues.Keys) {
    Set-ItemProperty -Path $clipboardPath -Name $name -Value $clipboardValues[$name] -Force
}

Write-Output "Registry keys successfully applied."

