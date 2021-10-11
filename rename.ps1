######################################
#Requirements:
#The command only runs under Powershell admin and local PCs(Which is 99% local only).
#Right click this powershell script run as administrator
#Use the one below if doing it on Active Directory domain computers. It will prompt you for a domain admin account.
#Rename-Computer -Computer 'OldComputerName' -NewName 'NewComputerName' -DomainCredential domain\user
#
#The PC will proceed to restart to change the name. THIS is necessary for Windows
####################
#Naming Convention
#
#Follow the format of <Store initials><Store 4 digits#>-<PCNumber>
#Example for a SDA store, 2059, with 6 computers
#SDA2059-01, SDA2059-02, SDA2059-03, etc... SDA2059-06.
######################################

# Self-elevate the script if required. This section will autoelevate Powershell into Powershell Administrator if not already running.
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
	if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
		$CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
		Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
	Exit
	}
}

#Change ComputerName below
Rename-Computer -NewName "ComputerName" -Restart 
