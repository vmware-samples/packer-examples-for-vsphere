# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<#
    .DESCRIPTION
    Windows Remote Management configuration initialization.
#>

$ErrorActionPreference = 'Stop'

$firewallGroupName = 'Windows Remote Management'
$httpFirewallRuleDisplayName = 'Windows Remote Management (HTTP-In)'
$httpsFirewallRuleName = 'WINRM-HTTPS-In-TCP'
$httpsFirewallRuleDisplayName = 'Windows Remote Management (HTTPS-In)'
$httpsFirewallRuleDescription = 'Windows Remote Management Inbound HTTPS [TCP 5986]'
$httpsFirewallRuleProgram = 'System'
$httpsFirewallRuleAction = 'Allow'
$httpsFirewallRuleEnabled = 'False'
$httpsPort = 5986
$protocol = 'TCP'
$transport = 'HTTPS'

$logDirectory = 'C:\Packer'
$logFile = 'C:\windows-winrm-init.log'

# Start the Windows Remote Management configuration initialization logging.
Start-Transcript -Path $logFile -Force
Write-Output 'Starting the Windows Remote Management configuration initialization logging...'

# Start the Windows Remote Management configuration initialization.
Write-Output 'Starting the Windows Remote Management configuration initialization...'

# Get the operating system information.
Write-Output 'Getting the operating system information...'
$osType = (Get-CimInstance -ClassName Win32_OperatingSystem).InstallationType.ToLower()
Write-Output "Operating system type: $osType"

# Disable the Network Location Wizard.
Write-Output 'Disabling the Network Location Wizard...'
New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff' -Force | Out-Null

# Set network connections profile to private.
Write-Output 'Setting the network connection profiles to private...'
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private -Verbose

if ($osType -eq 'client') {
    # Set the Windows Remote Management on Windows Desktop configuration
    Write-Output 'Setting the Windows Remote Management on Windows Desktop configuration initialization...'
    Write-Output 'This configuration will be removed during the build cleanup.'
    Enable-PSRemoting -SkipNetworkProfileCheck -Force
    $wsmanConfig = @{
        'winrm/config' = @{MaxTimeoutms = 18000};
        'winrm/config/winrs' = @{MaxMemoryPerShellMB = 1024};
        'winrm/config/service' = @{AllowUnencrypted = 'true'};
        'winrm/config/service/auth' = @{Negotiate = 'true'};
    }
    foreach ($entry in $wsmanConfig.GetEnumerator()) {
        Set-WSManInstance -ResourceURI $entry.Name -ValueSet $entry.Value
    }

    # Allow Windows Remote Management in the Windows Firewall.
    Write-Output 'Allowing Windows Remote Management in the Windows Firewall...'
    Enable-NetFirewallRule -DisplayGroup $firewallGroupName -PassThru |
    Get-NetFirewallRule -DisplayGroup $firewallGroupName |
    Get-NetFirewallAddressFilter |
    Where-Object { $_.RemoteAddress -Like 'LocalSubnet*' } |
    Get-NetFirewallRule |
    Set-NetFirewallRule -RemoteAddress Any |
    Set-NetFirewallRule -DisplayName $httpFirewallRuleDisplayName -EdgeTraversalPolicy Allow -Confirm:$false
} elseif (($osType -eq 'server') -or ($osType -eq 'server core')) {
    # Add the Windows Remote Management HTTPS listeners.
    Write-Output 'Adding the Windows Remote Management HTTPS listeners...'
    $certificate = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName $env:COMPUTERNAME
    New-Item -Path WSMan:\LocalHost\Listener -Transport $transport -Address * -CertificateThumbPrint $certificate.Thumbprint -Hostname $env:COMPUTERNAME -Port $httpsPort -Force | Out-Null

    # Set the Windows Remote Management trusted hosts to all.
    Write-Output 'Setting the Windows Remote Management trusted hosts to all...'
    Set-Item -Path WSMan:\localhost\Client/TrustedHosts -Value * -Force

    # Remove the default Windows Remote Management HTTP listener.
    Write-Output 'Removing the default Windows Remote Management HTTP listener...'
    Get-ChildItem WSMan:\localhost\Listener | Where-Object { $_.Keys -contains 'Transport=HTTP' } | Remove-Item -Recurse -Confirm:$false

    # Set the Windows Remote Management NTLM authentication configuration.
    Write-Output 'Setting the Windows Remote Management NTLM authentication configuration...'
    $ntlmConfig = @{
        'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' = @{ 'LmCompatibilityLevel' = 2 };
        'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0' = @{ 'NTLMMinServerSec' = 536870912 };
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' = @{ 'LocalAccountTokenFilterPolicy' = 1 };
    }
    foreach ($entry in $ntlmConfig.GetEnumerator()) {
        Set-ItemProperty -Path $entry.Name -Name $entry.Value.Keys -Value $entry.Value.Values -Type DWord -Force
    }

    # Disable the default Windows Remote Management firewall group rules.
    Write-Output 'Disabling the default Windows Remote Management firewall group rules...'
    Disable-NetFirewallRule -DisplayGroup $firewallGroupName

    # Set the Windows Remote Management over Inbound HTTPS on TCP 5986 firewall rule.
    Write-Output 'Setting the Windows Remote Management over Inbound HTTPS on TCP 5986 firewall rule...'
    New-NetFirewallRule `
        -Name $httpsFirewallRuleName `
        -DisplayName $httpsFirewallRuleDisplayName `
        -Description $httpsFirewallRuleDescription `
        -Group $firewallGroupName `
        -Program $httpsFirewallRuleProgram `
        -Protocol $protocol `
        -LocalPort $httpsPort `
        -Action $httpsFirewallRuleAction `
        -Enabled $httpsFirewallRuleEnabled -ErrorAction SilentlyContinue

    # Enable Windows Remote Management over HTTPS in the Windows Firewall.
    Write-Output 'Enabling Windows Remote Management over HTTPS in the Windows Firewall...'
    Enable-NetFirewallRule -DisplayName $httpsFirewallRuleDisplayName -ErrorAction SilentlyContinue
}

# Set the AutoLogonCount to 0.
Write-Output 'Setting the AutoLogonCount to 0...'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AutoLogonCount' -Value 0 -Force

# Stop the Windows Remote Management configuration initialization logging.
Write-Output 'Stopping the Windows Remote Management configuration initialization logging...'
Stop-Transcript

# Save the Windows Remote Management configuration initilization log.
Write-Output 'Saving the Windows Remote Management configuration initilization log...'
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

# Move the Windows Remote Management configuration initilization log.
Write-Output 'Moving the Windows Remote Management configuration initilization log...'
try {
    Move-Item -Path $logFile -Destination $logDirectory -Force -ErrorAction Stop
} catch {
    Write-Output "Failed to move log file: $_"
    exit 1
}

# Windows Remote Management configuration completed.
Write-Output 'Windows Remote Management configuration initialization completed.'

