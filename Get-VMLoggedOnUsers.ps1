Connect-VIServer MyvCenterServer
$VMs = Get-VM -Location "Workstations" | Where { ($_.PowerState -eq "PoweredOn") -and ($_.Guest.OSFullName -like "*Windows*") }
ForEach ($VM in $VMs) {
	Write-Host "Getting Logged on Users for: " $VM " - " $VM.Guest.HostName -ForegroundColor Green
	$LoggedOnUsers = (Get-WmiObject Win32_LoggedOnUser -ComputerName $VM.Guest.HostName | Where {$_.Antecedent -Match (Get-ADDomain).NetBIOSName } | Where {$_.Antecedent -NotMatch $env:username } | Select Antecedent -Unique | %{"{0}\{1}" -f $_.Antecedent.ToString().Split(’"‘)[1], $_.Antecedent.ToString().Split(’"‘)[3]}) -Join ";"
	If ($LoggedOnUsers)	{
		Write-Host "Logged On Users: "$LoggedOnUsers
	} else {
		Write-Host "No Logged On Users: "$LoggedOnUsers
#		Write-Host "Updating Tools on VM: "$VM
#		Update-Tools $VM -NoReboot -RunAsync
	}
}

