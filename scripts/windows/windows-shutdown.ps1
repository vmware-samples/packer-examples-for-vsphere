# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

<#
    .DESCRIPTION
    Disables Windows Remote Management on Windows builds.
#>

$ErrorActionPreference = 'Stop'

$httpFirewallRuleDisplayName = 'Windows Remote Management (HTTP-In)'

# Disable PowerShell Remoting.
Write-Output 'Disabling PowerShell Remoting...'
try {
    Disable-PSRemoting -Force -Confirm:$false

    # Add a check to ensure that PowerShell Remoting is disabled.
    if ((Get-PSSessionConfiguration -Name Microsoft.PowerShell -ErrorAction SilentlyContinue).Enabled) {
        throw 'Failed to disable PowerShell Remoting.'
    }
} catch {
    Write-Output "Failed to disable PowerShell Remoting: $_"
    exit 1
}

# Disable Windows Remote Management service.
Write-Output 'Disabling Windows Remote Management service...'
try {
    Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system -Name LocalAccountTokenFilterPolicy -Value 0
    Stop-Service -Name WinRM
    Set-Service -Name WinRM -StartupType Disabled
    $count = 0
    while ((Get-Service -Name WinRM).Status -ne 'Stopped' -and $count -lt 10) {
        Start-Sleep -Seconds 2
        $count++
    }
    if ((Get-Service -Name WinRM).Status -ne 'Stopped') {
        throw 'Failed to stop WinRM service within the expected time.'
    }
} catch {
    Write-Output "Failed to disable Windows Remote Management service: $_"
    exit 1
}

# Block Windows Remote Management in the Windows Firewall.
Write-Output 'Blocking Windows Remote Management in the Windows Firewall...'
try {
    if (Get-NetFirewallRule -DisplayName $httpFirewallRuleDisplayName -ErrorAction SilentlyContinue) {
        Set-NetFirewallRule -DisplayName $httpFirewallRuleDisplayName -Enabled False -PassThru
    } else {
        Write-Output "Firewall rule '$httpFirewallRuleDisplayName' does not exist."
    }
} catch {
    Write-Output "Failed to disable firewall rule: $_"
    exit 1
}

# Shutdown the machine.
shutdown /s /t 10 /f /d p:4:1 /c \"Shutdown by Packer\"
