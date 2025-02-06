# © Broadcom. All Rights Reserved.
# The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-2-Clause

<#
    .DESCRIPTION
    Installs VMware Tools and runs re-attempts if the services fail on the first attempt.

    .SYNOPSIS
    - Packer requires that the VMware Tools service is running.
    - If the VMware Tools service fails to start, the script initiates a reinstallation.
#>

param (
  [string]$SetupPath = "E:",
  [int]$MaxRetries = 5,
  [int]$RetryInterval = 2
)

$ErrorActionPreference = "Stop"
$VMToolsName = "VMware Tools"
$VMToolsServiceName = "VMTools"

Function Get-VMToolsInstall {
  $registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
  )
  foreach ($path in $registryPaths) {
    try {
      if (Get-ChildItem $path -ErrorAction Stop | Where-Object { $_.GetValue("DisplayName") -like "*$VMToolsName*" }) {
        return $true
      }
    } catch {
      Write-Error ("Failed to access registry path: {0}. {1}" -f $path, $_)
    }
  }

  return $false
}

Function Get-VMToolsService {
  param (
    [int]$MaxRetries,
    [int]$RetryInterval
  )

  Write-Output "Checking $VMToolsName service status..."
  for ($i = 0; $i -lt $MaxRetries; $i++) {
    Start-Sleep -Seconds $RetryInterval
    try {
      $Service = Get-Service $VMToolsServiceName -ErrorAction Stop
      if ($Service.Status -eq "Running") {
        Write-Output "$VMToolsName service is in a running state."
        return $true
      }
    } catch {
      Write-Error ("Failed to get service status: {0}" -f $_)
    }
  }
  return $false
}

Function Install-VMTools {
  param (
    [string]$SetupPath,
    [string]$Arguments
  )

  Write-Output "Installing $VMToolsName..."
  try {
    Start-Process -FilePath "$SetupPath\setup.exe" -ArgumentList $Arguments -Wait
    return $true
  } catch {
    Write-Error ("Failed to install {0}: {1}" -f $VMToolsName, $_)
    return $false
  }
}

# Check if VMware Tools is installed.
$vmToolsInstalled = Get-VMToolsInstall

if ($vmToolsInstalled) {
  # Check if VMware Tools service is running.
  $vmToolsServiceRunning = Get-VMToolsService -MaxRetries $MaxRetries -RetryInterval $RetryInterval

  if ($vmToolsServiceRunning) {
    Write-Output "$VMToolsName is already installed and running."
    exit 0
  } else {
    Write-Output "$VMToolsName service is not running. Uninstalling and reinstalling..."
    try {
      $GUID = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction Stop | Where-Object { $_.DisplayName -Like "*$VMToolsName*" }).PSChildName
      Start-Process -FilePath msiexec.exe -ArgumentList "/X $GUID /quiet /norestart" -Wait
    } catch {
      Write-Error ("Failed to uninstall {0}: {1}" -f $VMToolsName, $_)
      exit 1
    }
  }
} else {
  Write-Output "$VMToolsName is not installed. Proceeding with installation..."
}

# Install VMware Tools.
if (-not (Install-VMTools -SetupPath $SetupPath -Arguments '/s /v "/qb REBOOT=R"')) {
  Write-Error "Failed to install $VMToolsName"
} else {
  Write-Output "$VMToolsName installed successfully."
}

# Check if VMware Tools service is running after installation.
if (-not (Get-VMToolsService -MaxRetries $MaxRetries -RetryInterval $RetryInterval)) {
  Write-Error "$VMToolsName service is not running"
} else {
  Write-Output "$VMToolsName service is running."
}
