# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<#
    .DESCRIPTION
    Prepares a Windows Server guest operating system.
#>

param(
    [string] $BUILD_USERNAME = $env:BUILD_USERNAME
)

$ErrorActionPreference = "Stop"

# Import the Root CA certificate to the Trusted Root Certification Authorities.
Write-Output "Importing the Root CA certificate to the Trusted Root Certification Authorities ..."
Import-Certificate -FilePath C:\windows\temp\root-ca.cer -CertStoreLocation 'Cert:\LocalMachine\Root' | Out-Null
Remove-Item C:\windows\temp\root-ca.cer -Confirm:$false

# Import the Issuing CA certificate to the Trusted Root Certification Authoriries.
### Write-Output "Importing the Issuing CA certificate to the Trusted Root Certification Authoriries ..."
### Import-Certificate -FilePath C:\windows\temp\issuing-ca.cer -CertStoreLocation 'Cert:\LocalMachine\CA' | Out-Null
### Remove-Item C:\windows\temp\issuing-ca.cer -Confirm:$false

# Set the Windows Explorer options.
Write-Output "Setting the Windows Explorer options ..."
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Value 0 | Out-Null

# Set Net Network Window = Off.
Write-Output "Setting Net Network Window = Off ..."
New-Item "HKLM:\System\CurrentControlSet\Control\Network\" -Name "NewNetworkWindowOff" | Out-Null

# Enable QuickEdit mode.
Write-Output "Enabling QuickEdit mode ..."
Set-ItemProperty "HKCU:\Console" -Name "QuickEdit" -Value 1 -Type DWord | Out-Null

# Show Run Command in Start Menu.
Write-Output "Showing Run Command in Start Menu ..."
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "Start_ShowRun" -Value 1 -Type DWord | Out-Null

# Show Administrative Tools in Start Menu.
Write-Output "Showing Administrative Tools in Start Menu ..."
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "StartMenuAdminTools" -Value 1 -Type DWord | Out-Null

# Disable system hibernation.
Write-Output "Disabling system hibernation ..."
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HiberFileSizePercent" -Value 0 | Out-Null
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HibernateEnabled" -Value 0 | Out-Null

# Disable TLS 1.0.
Write-Output "Disabling TLS 1.0 ..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.0" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Server" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Client" | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledByDefault" -Value 1 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Value 1 | Out-Null

# Disable TLS 1.1.
Write-Output "Disabling TLS 1.1 ..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.1" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Server" | Out-Null
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Client" | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledByDefault" -Value 1 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0 | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1 | Out-Null

# Disable Password Expiration for the Administrator Accounts - (Administration and Rainpole)
Write-Output "Disabling password expiration for the local Administrator accounts ..."
Set-LocalUser Administrator -PasswordNeverExpires $true
Set-LocalUser $BUILD_USERNAME -PasswordNeverExpires $true

# Enable Remote Desktop.
Write-Output "Enabling Remote Desktop ..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 | Out-Null
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Disable Auto Login.
Write-Output "Disabling Auto Login ..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoAdminLogon" -Value 0 | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoLogonCount" -Value 0 | Out-Null

# Disable the screensaver.
Write-Output "Disabling the screensaver ..."
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value 0 -Type DWord | Out-Null
& powercfg -x -monitor-timeout-ac 0
& powercfg -x -monitor-timeout-dc 0