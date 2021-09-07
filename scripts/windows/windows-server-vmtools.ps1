# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<#
    .DESCRIPTION
    Installs VMware Tools and runs re-attempts if the services fail on the first attempt.
    
    .SYNOPSIS
    - Packer requires the VMware Tools service is running at the end of the build.
    - If the "VMware Tools Service" fails to istart, the script initiates a reinstallation.

    .NOTES
    The below code is mostly based on the script within the following blog post by Owen Reynolds from scriptech.io.
    https://scriptech.io/automatically-reinstalling-vmware-tools-on-server2016-after-the-first-attempt-fails-to-install-the-vmtools-service/
#>

$ErrorActionPreference = "Stop"

# Install VMWare Tools
Function Get-VMToolsInstalled {
    
    IF (((Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall") | Where-Object { $_.GetValue( "DisplayName" ) -like "*VMware Tools*" } ).Length -gt 0) {
        
        [int]$Version = "32"
    }

    IF (((Get-ChildItem "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall") | Where-Object { $_.GetValue( "DisplayName" ) -like "*VMware Tools*" } ).Length -gt 0) {

       [int]$Version = "64"
    }    

    return $Version
}

### 1 - Set the current working directory to the CD-ROM that corresponds to the VMWare Tools .iso.

Set-Location e:

### 2 - Installation Attempt #1

write-host "Starting VMware Tools first pass installation ..." -ForegroundColor cyan
Start-Process "setup64.exe" -ArgumentList '/s /v "/qb REBOOT=R"' -Wait

### 3 - After the installation is finished, check to see if the 'VMTools' service is in a 'Running' state.

$Running = $false
$iRepeat = 0

while (-not$Running -and $iRepeat -lt 5) {

  write-host "Pausing for 2s to check the status VMware Tools ..." -ForegroundColor cyan 
  Start-Sleep -s 2
  $Service = Get-Service "VMTools" -ErrorAction SilentlyContinue
  $Servicestatus = $Service.Status

  if ($ServiceStatus -notlike "Running") {

    $iRepeat++

  }
  else {

    $Running = $true
    write-host "VMware Tools is in a running state." -ForegroundColor green

  }

}

### 4 - If the service never enters the 'Running' state, re-install VMware Tools.
if (-not$Running) {

  #Uninstall VMWare Tools
  write-host "Running a un-install on first attempt of the VMware Tools installation ..." -ForegroundColor cyan

  IF (Get-VMToolsInstalled -eq "32") {
  
    $GUID = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Like '*VMWARE Tools*' }).PSChildName

  }

  Else {
  
    $GUID = (Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Like '*VMWARE Tools*' }).PSChildName

  }

  ### 5 - Un-install VMware Tools based on 32-bit/64-bit install GUIDs captured via Get-VMToolsIsInstalled function
  
  Start-Process -FilePath msiexec.exe -ArgumentList "/X $GUID /quiet /norestart" -Wait  

  write-host "Running a re-install of VMware Tools ..." -ForegroundColor cyan 
  #Install VMWare Tools
  Start-Process "setup64.exe" -ArgumentList '/s /v "/qb REBOOT=R"' -Wait

  ### 6 - Re-check again if VMTools service has been installed and is started

Write-host "Checking on the status of VMware Tools again ..." -ForegroundColor Cyan
  
$iRepeat = 0
while (-not$Running -and $iRepeat -lt 5) {

    Start-Sleep -s 2
    $Service = Get-Service "VMTools" -ErrorAction SilentlyContinue
    $ServiceStatus = $Service.Status
    
    If ($ServiceStatus -notlike "Running") {

      $iRepeat++

    }

    Else {

      $Running = $true
      write-host "VMware Tools is in a running state." -ForegroundColor green

    }

  }

  ### 7 If after the reinstall, the service is still not running, this is a failed deployment.

  IF (-not$Running) {
    
    Write-Host -ForegroundColor Red "VMware Tools deployment was unsuccesfull."
    Pause

  }

}