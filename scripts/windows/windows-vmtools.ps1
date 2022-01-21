# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<#
    .DESCRIPTION
    Installs VMware Tools and runs re-attempts if the services fail on the first attempt.

    .SYNOPSIS
    - Packer requires the VMware Tools service is running at the end of the build.
    - If the "VMware Tools Service" fails to start, the script initiates a reinstallation.

    .NOTES
    The below code is mostly based on the script within the following blog post by Owen Reynolds from scriptech.io.
    https://scriptech.io/automatically-reinstalling-vmware-tools-on-server2016-after-the-first-attempt-fails-to-install-the-vmtools-service/
#>

$ErrorActionPreference = "Stop"

# Install VMWare Tools

Function Get-VMToolsInstalled {
    if (((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") | Where-Object { $_.GetValue( "DisplayName" ) -like "*VMware Tools*" } ).Length -gt 0) {
        [int]$Version = "32"
    }
    if (((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") | Where-Object { $_.GetValue( "DisplayName" ) -like "*VMware Tools*" } ).Length -gt 0) {
       [int]$Version = "64"
    }
    return $Version
}

# Set the current working directory to the CD-ROM that corresponds to the VMWare Tools .iso.

Set-Location E:

# Installation Attempt

Write-Output "Starting VMware Tools first pass installation..."
Start-Process "setup64.exe" -ArgumentList '/s /v "/qb REBOOT=R"' -Wait

# Check to see if the 'VMTools' service is in a 'Running' state.

$Running = $false
$iRepeat = 0

while (-not$Running -and $iRepeat -lt 5) {

  Write-Output "Pausing for 2s to check the status VMware Tools..."
  Start-Sleep -s 2
  $Service = Get-Service "VMTools" -ErrorAction SilentlyContinue
  $Servicestatus = $Service.Status

  if ($ServiceStatus -notlike "Running") {
    $iRepeat++
  }
  else {
    $Running = $true
    Write-Output "VMware Tools is in a running state."
  }
}

# If the service never enters the 'Running' state, reinstall VMware Tools.

if (-not $Running) {
  #Uninstall VMWare Tools
  Write-Output "Running an uninstall on first attempt of the VMware Tools installation..."
  if (Get-VMToolsInstalled -eq "32") {
    $GUID = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Like '*VMWARE Tools*' }).PSChildName
  }
  else {
    $GUID = (Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Like '*VMWARE Tools*' }).PSChildName
  }

  # Uninstall VMware Tools based on 32-bit/64-bit install GUIDs captured via Get-VMToolsIsInstalled

  Start-Process -FilePath msiexec.exe -ArgumentList "/X $GUID /quiet /norestart" -Wait
  Write-Output "Running a reinstall of VMware Tools..."

  # Installation Attempt

  Start-Process "setup64.exe" -ArgumentList '/s /v "/qb REBOOT=R"' -Wait

  # Check to see if the 'VMTools' service is in a 'Running' state.

Write-Output "Checking on the status of VMware Tools..."

$iRepeat = 0
while (-not $Running -and $iRepeat -lt 5) {
    Start-Sleep -s 2
    $Service = Get-Service "VMTools" -ErrorAction SilentlyContinue
    $ServiceStatus = $Service.Status

    if ($ServiceStatus -notlike "Running") {
      $iRepeat++
    }
    else {
      $Running = $true
      Write-Output "VMware Tools is in a running state."
    }
  }

  # If after the reinstall, the service is still not running, this is a failed deployment.

  if (-not $Running) {
    Write-Error "VMware Tools deployment was unsuccesful."
    Pause
  }

}