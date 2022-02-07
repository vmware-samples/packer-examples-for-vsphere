<?xml version="1.0" encoding="UTF-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
   <settings pass="windowsPE">
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <SetupUILanguage>
            <UILanguage>${vm_inst_os_language}</UILanguage>
         </SetupUILanguage>
         <InputLocale>${vm_inst_os_keyboard}</InputLocale>
         <SystemLocale>${vm_inst_os_language}</SystemLocale>
         <UILanguage>${vm_inst_os_language}</UILanguage>
         <UILanguageFallback>${vm_inst_os_language}</UILanguageFallback>
         <UserLocale>${vm_inst_os_language}</UserLocale>
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-PnpCustomizationsWinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <DriverPaths>
            <PathAndCredentials wcm:action="add" wcm:keyValue="1">
               <Path>E:\Program Files\VMware\VMware Tools\Drivers\pvscsi\Win8\amd64</Path>
            </PathAndCredentials>
         </DriverPaths>
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <DiskConfiguration>
            <Disk wcm:action="add">
               <DiskID>0</DiskID>
               <WillWipeDisk>true</WillWipeDisk>
               <CreatePartitions>
                  <!-- Windows RE Tools partition -->
                  <CreatePartition wcm:action="add">
                     <Order>1</Order>
                     <Type>Primary</Type>
                     <Size>300</Size>
                  </CreatePartition>
                  <!-- System partition (ESP) -->
                  <CreatePartition wcm:action="add">
                     <Order>2</Order>
                     <Type>EFI</Type>
                     <Size>100</Size>
                  </CreatePartition>
                  <!-- Microsoft reserved partition (MSR) -->
                  <CreatePartition wcm:action="add">
                     <Order>3</Order>
                     <Type>MSR</Type>
                     <Size>128</Size>
                  </CreatePartition>
                  <!-- Windows partition -->
                  <CreatePartition wcm:action="add">
                     <Order>4</Order>
                     <Type>Primary</Type>
                     <Extend>true</Extend>
                  </CreatePartition>
               </CreatePartitions>
               <ModifyPartitions>
                  <!-- Windows RE Tools partition -->
                  <ModifyPartition wcm:action="add">
                     <Order>1</Order>
                     <PartitionID>1</PartitionID>
                     <Label>WINRE</Label>
                     <Format>NTFS</Format>
                     <TypeID>DE94BBA4-06D1-4D40-A16A-BFD50179D6AC</TypeID>
                  </ModifyPartition>
                  <!-- System partition (ESP) -->
                  <ModifyPartition wcm:action="add">
                     <Order>2</Order>
                     <PartitionID>2</PartitionID>
                     <Label>System</Label>
                     <Format>FAT32</Format>
                  </ModifyPartition>
                  <!-- MSR partition does not need to be modified -->
                  <ModifyPartition wcm:action="add">
                     <Order>3</Order>
                     <PartitionID>3</PartitionID>
                  </ModifyPartition>
                  <!-- Windows partition -->
                  <ModifyPartition wcm:action="add">
                     <Order>4</Order>
                     <PartitionID>4</PartitionID>
                     <Label>OS</Label>
                     <Letter>C</Letter>
                     <Format>NTFS</Format>
                  </ModifyPartition>
               </ModifyPartitions>
            </Disk>
         </DiskConfiguration>
         <ImageInstall>
            <OSImage>
               <InstallFrom>
                  <MetaData wcm:action="add">
                     <Key>/IMAGE/NAME</Key>
                     <Value>${vm_inst_os_image}</Value>
                  </MetaData>
               </InstallFrom>
               <InstallTo>
                  <DiskID>0</DiskID>
                  <PartitionID>4</PartitionID>
               </InstallTo>
            </OSImage>
         </ImageInstall>
         <RunSynchronous>
            <RunSynchronousCommand>
               <Order>1</Order>
               <!-- Set power scheme to high performance in WinPE for faster imaging. -->
               <Path>cmd /c powercfg.exe /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c</Path>
            </RunSynchronousCommand>		
         </RunSynchronous>
         <UserData>
            <AcceptEula>true</AcceptEula>
            <FullName>${build_username}</FullName>
            <Organization>${build_username}</Organization>
            <ProductKey>
               <Key>${vm_inst_os_kms_key}</Key>
               <WillShowUI>OnError</WillShowUI>
            </ProductKey>
         </UserData>
         <EnableFirewall>false</EnableFirewall>
      </component>
   </settings>
   <settings pass="offlineServicing">
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-LUA-Settings" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <EnableLUA>false</EnableLUA>
      </component>
   </settings>
   <settings pass="generalize">
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Security-SPP" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <SkipRearm>1</SkipRearm>
      </component>
   </settings>
   <settings pass="specialize">
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <OEMInformation>
            <HelpCustomized>false</HelpCustomized>
         </OEMInformation>
         <TimeZone>${vm_guest_os_timezone}</TimeZone>
         <RegisteredOwner />
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-ServerManager-SvrMgrNc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <DoNotOpenServerManagerAtLogon>true</DoNotOpenServerManagerAtLogon>
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-OutOfBoxExperience" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <DoNotOpenInitialConfigurationTasksAtLogon>true</DoNotOpenInitialConfigurationTasksAtLogon>
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Security-SPP-UX" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <SkipAutoActivation>true</SkipAutoActivation>
      </component>
   </settings>
   <settings pass="oobeSystem">
      <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
         <InputLocale>${vm_guest_os_keyboard}</InputLocale>
         <SystemLocale>${vm_guest_os_language}</SystemLocale>
         <UILanguage>${vm_guest_os_language}</UILanguage>
         <UILanguageFallback>${vm_guest_os_language}</UILanguageFallback>
         <UserLocale>${vm_guest_os_language}</UserLocale>
      </component>
      <component xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS">
         <AutoLogon>
            <Password>
               <Value>${build_password}</Value>
               <PlainText>true</PlainText>
            </Password>
            <Enabled>true</Enabled>
            <Username>${build_username}</Username>
         </AutoLogon>
         <OOBE>
            <HideEULAPage>true</HideEULAPage>
            <HideLocalAccountScreen>true</HideLocalAccountScreen>
            <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
            <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
            <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
            <NetworkLocation>Work</NetworkLocation>
            <ProtectYourPC>2</ProtectYourPC>
         </OOBE>
         <UserAccounts>
            <AdministratorPassword>
               <Value>${build_password}</Value>
               <PlainText>true</PlainText>
            </AdministratorPassword>
            <LocalAccounts>
               <LocalAccount wcm:action="add">
                  <Password>
                     <Value>${build_password}</Value>
                     <PlainText>true</PlainText>
                  </Password>
                  <Group>administrators</Group>
                  <DisplayName>${build_username}</DisplayName>
                  <Name>${build_username}</Name>
                  <Description>Build Account</Description>
               </LocalAccount>
            </LocalAccounts>
         </UserAccounts>
         <FirstLogonCommands>
            <SynchronousCommand wcm:action="add">
               <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
               <Description>Set Execution Policy 64-Bit</Description>
               <Order>1</Order>
               <RequiresUserInput>true</RequiresUserInput>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
               <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
               <Description>Set Execution Policy 32-Bit</Description>
               <Order>2</Order>
               <RequiresUserInput>true</RequiresUserInput>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
               <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -File F:\windows-vmtools.ps1</CommandLine>
               <Order>3</Order>
               <Description>Install VMware Tools</Description>
            </SynchronousCommand>
            <SynchronousCommand wcm:action="add">
               <CommandLine>%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -File F:\windows-init.ps1</CommandLine>
               <Order>4</Order>
               <Description>Initial Configuration</Description>
            </SynchronousCommand>
         </FirstLogonCommands>
      </component>
   </settings>
</unattend>