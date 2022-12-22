# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

<#
    .DESCRIPTION
    Prepares a Windows guest operating system.
#>

param(
    [string] $BUILD_USERNAME = $env:BUILD_USERNAME
)

$ErrorActionPreference = "Stop"

function Set-RegistryValue {
    param (
        [Parameter(Mandatory=$true)] [string]$Path,
        [Parameter(Mandatory=$true)] [string]$Name,
        [Parameter(Mandatory=$true)] [string]$Value
    )

    Set-ItemProperty -Path $Path -Name $Name -Value $Value | Out-Null
}

function Disable-TLS {
    param (
        [Parameter(Mandatory=$true)] [string]$Version
    )

    Write-Output "Disabling TLS $Version..."
    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS $Version"

    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
        New-Item -Path "$path\Server" -Force | Out-Null
        New-Item -Path "$path\Client" -Force | Out-Null
        Set-RegistryValue -Path "$path\Client" -Name "Enabled" -Value 0
        Set-RegistryValue -Path "$path\Client" -Name "DisabledByDefault" -Value 1
        Set-RegistryValue -Path "$path\Server" -Name "Enabled" -Value 0
        Set-RegistryValue -Path "$path\Server" -Name "DisabledByDefault" -Value 1
    }
}

# Set the Windows Explorer options.
Write-Output "Setting Windows Explorer options..."
$explorerOptions = @{
    "Hidden" = 1
    "HideFileExt" = 0
    "HideDrivesWithNoMedia" = 0
    "ShowSyncProviderNotifications" = 0
}
foreach ($option in $explorerOptions.GetEnumerator()) {
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name $option.Name -Value $option.Value
}

# Disable system hibernation.
Write-Output "Disabling system hibernation..."
$hibernationOptions = @{
    "HiberFileSizePercent" = 0
    "HibernateEnabled" = 0
}
foreach ($option in $hibernationOptions.GetEnumerator()) {
    Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name $option.Name -Value $option.Value
}

# Disable TLS 1.0 and 1.1
Disable-TLS -Version "1.0"
Disable-TLS -Version "1.1"

# Disable Password Expiration for the Administrator Accounts - (Administrator and Build)
if ($user = Get-LocalUser -Name $BUILD_USERNAME -ErrorAction SilentlyContinue) {
    Write-Output "Disabling password expiration for the local Administrator accounts..."
    Set-LocalUser -Name $localAdministrator -PasswordNeverExpires $true
    Set-LocalUser -Name $BUILD_USERNAME -PasswordNeverExpires $true
} else {
    Write-Output "User $BUILD_USERNAME does not exist."
}

# Enable Remote Desktop.
Write-Output "Enabling Remote Desktop..."
$rdpOptions = @{
    "fDenyTSConnections" = 0
    "UserAuthentication" = 0
}
foreach ($option in $rdpOptions.GetEnumerator()) {
    try {
        Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name $option.Name -Value $option.Value
    } catch {
        Write-Output "Failed to set Remote Desktop option $option.Name: $_"
    }
}
try {
    Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28752'
    Write-Output "Remote Desktop enabled successfully."
} catch {
    Write-Output "Failed to enable Remote Desktop firewall rule: $_"
}
