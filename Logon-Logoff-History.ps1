# https://github.com/DarrenRainey/qsdt/
# This script will attempt to get the last few logins/logoffs on a machine and display then in the console
# Pending optimisation
# Run on remote pc with - Invoke-Command -FilePath Logon-Logoff-History.ps1 -ComputerName mycomputer.local -Credential Domain\User
$result = Get-WinEvent -FilterHashtable @{LogName="Security";Id=4648},@{LogName="Security";Id=4624} -MaxEvents 500 | ForEach-Object {
    $eventXml = ([xml]$_.ToXml()).Event
    $evt = [ordered]@{
        EventDate = [DateTime]$eventXml.System.TimeCreated.SystemTime
        Computer  = $eventXml.System.Computer
    }
    $eventXml.EventData.ChildNodes | ForEach-Object { $evt[$_.Name] = $_.'#text' }
    # output as PsCustomObject. This ensures the $result array can be written to CSV easily
    [PsCustomObject]$evt
}

# output to screen
$out = $result | where-object {$_.TargetUserName -ne "SYSTEM"} | where-object {$_.LogonType -ne $null} | select-object "EventDate","Computer","TargetUserName","LogonType" 

for($count = 0; $count -ne $out.count; $count++){
	$logType = $out[$count].LogonType -replace(2,"Logon") -replace(5,"Logoff")
	Write-Host $out[$count].EventDate $out[$count].Computer $logType $out[$count].TargetUserName
}
