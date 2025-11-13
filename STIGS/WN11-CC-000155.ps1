<#
.SYNOPSIS
    Configures Windows Terminal Services and Remote Assistance policy registry settings in compliance with security requirements.

.NOTES
    Author          : Terrence Biddix
    LinkedIn        : linkedin.com/in/terrence-biddix-b4416b202
    GitHub          : github.com/Terrence-Biddix
    Date Created    : 2025-11-13
    Last Modified   : 2025-11-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000155

.TESTED ON
    Date(s) Tested  : 2025-11-13
    Tested By       : Terrence Biddix
    Systems Tested  : Windows 11 pro V2 x64
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    1. Save the script as: Set-TerminalServicesPolicy.ps1
    2. Right-click PowerShell → “Run as Administrator”.
    3. Navigate to the script directory:
           cd C:\Path\To\Script
    4. Run the script:
           .\Set-TerminalServicesPolicy.ps1
    5. After execution, verify settings using:
           Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000155).ps1 

  
#>

# Ensure script runs with admin rights
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this PowerShell script as Administrator." -ForegroundColor Red
    exit
}

# Define base registry paths
$basePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$clientPath = "$basePath\Client"
$usbBlockPath = "$clientPath\UsbBlockDeviceBySetupClasses"
$usbSelectPath = "$clientPath\UsbSelectDeviceByInterfaces"

# Create all required paths if they don’t exist
New-Item -Path $basePath -Force | Out-Null
New-Item -Path $clientPath -Force | Out-Null
New-Item -Path $usbBlockPath -Force | Out-Null
New-Item -Path $usbSelectPath -Force | Out-Null

# Set main Terminal Services values
New-ItemProperty -Path $basePath -Name "KeepAliveEnable" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $basePath -Name "KeepAliveInterval" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $basePath -Name "fAllowToGetHelp" -PropertyType DWord -Value 0 -Force | Out-Null

# Set Client values
New-ItemProperty -Path $clientPath -Name "fEnableUsbBlockDeviceBySetupClass" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $clientPath -Name "fEnableUsbNoAckIsochWriteToDevice" -PropertyType DWord -Value 0x50 -Force | Out-Null
New-ItemProperty -Path $clientPath -Name "fEnableUsbSelectDeviceByInterface" -PropertyType DWord -Value 1 -Force | Out-Null

# Set USB Block Device by Setup Classes
New-ItemProperty -Path $usbBlockPath -Name "1000" -PropertyType String -Value "{3376f4ce-ff8d-40a2-a80f-bb4359d1415c}" -Force | Out-Null

# Set USB Select Device by Interfaces
New-ItemProperty -Path $usbSelectPath -Name "1000" -PropertyType String -Value "{6bdd1fc6-810f-11d0-bec7-08002be2092f}" -Force | Out-Null

Write-Host "Registry configuration successfully applied." -ForegroundColor Green

