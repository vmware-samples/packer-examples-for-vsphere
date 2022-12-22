# Copyright 2023 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

<#
    .DESCRIPTION
    Windows Remote Management configuration reset for Windows Desktop.
#>

$ErrorActionPreference = 'Stop'

$firewallGroupName = 'Windows Remote Management'
$httpFirewallRuleDisplayName = 'Windows Remote Management (HTTP-In)'
$httpsFirewallRuleName = 'WINRM-HTTPS-In-TCP'
$httpsFirewallRuleDisplayName = 'Windows Remote Management (HTTPS-In)'
$protocol = 'TCP'
$transport = 'HTTPS'

$logDirectory = 'C:\Packer'
$logFile = 'C:\windows-winrm-reset.log'

# Start the logging for the Windows Remote Management reset.
Start-Transcript -Path $logFile -Force
Write-Output 'Starting the logging for the Windows Remote Management reset...'

# Start the Windows Remote Management configuration reset.
Write-Output 'Starting the Windows Remote Management reset...'

# Get the operating system information.
Write-Output 'Getting the operating system information...'
$osType = (Get-CimInstance -ClassName Win32_OperatingSystem).InstallationType.ToLower()
Write-Output "Operating system type: $osType"

# Check if Windows Remote Management service is running.
$service = Get-Service -Name WinRM -ErrorAction SilentlyContinue

if ($null -eq $service) {
    Write-Output "Windows Remote Management service does not exist."
    exit 1
} elseif ($service.Status -ne 'Running') {
    Write-Output "Windows Remote Management service is not running, starting it now..."
    try {
        Start-Service -Name WinRM -ErrorAction Stop
    } catch {
        Write-Output "Failed to start WinRM service: $_"
        exit 1
    }
}

# Reset the Windows Remote Management configuration to the default settings if the operating system is a client.
if ($osType -eq 'client') {
    Write-Output 'Resetting the Windows Remote Management configuration to the default settings...'
    try {
        Disable-PSRemoting -Force
        Get-ChildItem WSMan:\localhost\Listener | Where-Object { $_.Keys -contains "Transport=$transport" } | Remove-Item -Recurse -Confirm:$false
        Get-NetFirewallRule -DisplayName $httpFirewallRuleDisplayName | Remove-NetFirewallRule -Confirm:$false
        Get-NetFirewallRule -Name $httpsFirewallRuleName | Remove-NetFirewallRule -Confirm:$false
    } catch {
        Write-Output "Failed to reset Windows Remote Management configuration: $_"
        exit 1
    }
}

# Stop the Windows Remote Management configuration reset logging.
Write-Output 'Stopping the Windows Remote Management configuration reset logging...'
Stop-Transcript

# Save the Windows Remote Management configuration reset log.
Write-Output 'Saving the Windows Remote Management configuration reset log...'
try {
    New-Item -Path $logDirectory -Type Directory -Force | Out-Null
    $acl = Get-Acl $logDirectory
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('Administrators', 'FullControl', 'ContainerInherit,Objectinherit', 'none', 'Allow')
    $acl.AddAccessRule($rule)
    Set-Acl -Path $logDirectory -AclObject $acl
} catch {
    Write-Output "Failed to set ACL for '$logDirectory': $_"
    exit 1
}

# Move the Windows Remote Management configuration reset log.
Write-Output 'Moving the Windows Remote Management configuration reset log...'
try {
    Move-Item -Path $logFile -Destination $logDirectory -Force -ErrorAction Stop
} catch {
    Write-Output "Failed to move log file: $_"
    exit 1
}

# Windows Remote Management configuration reset completed.
Write-Output 'Windows Remote Management configuration reset completed.'
