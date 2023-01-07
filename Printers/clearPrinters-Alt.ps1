# Alternative version of clearPrinters using WMIC and PSService to restart services
# For when PS Remoting is disabled.
# Note currently a small visual bug where the first printer / printer 0 may not display if there is only 1 printer in an error/non zero state
# this will be fixed at a later stage but does not affect functionality.
function clearPrinter($remotePC){
$printers = GWMI -Class Win32_Printer -ComputerName $remotePC | Where-Object {$_.PrinterState -ne 0 -and $_.PrinterState -ne 128}
$remotePCiP = [System.Net.Dns]::GetHostAddresses($remotePC).IPAddressToString
$menu = @{}
$count = $printers | Measure-Object	
for ($i=1;$i -le $count.count; $i++) 
{ Write-Host "$i. $($printers[$i-1].name),$($printers[$i-1].printerstatus)" 
$menu.Add($i,($printers[$i-1].name))}


[int]$ans = Read-Host 'Enter selection'

$clearPrinter = $printers[$ans-1].name
echo Clearing $clearPrinter
$pf =  "`"name LIKE '%$clearPrinter%'`""
WMIC.exe /node:$remotePCiP printjob where $pf DELETE

if($count.count -eq 0){
	echo "No printers in an error state"
	break;
}

echo "Restarting Services"
.\PsExec.exe \\$remotePC net stop spooler /y
.\PsExec.exe \\$remotePC net start spooler /y

echo "All print jobs should be cleared / Print spooler restarted"
Set-Clipboard "Print queue cleared for $clearPrinter"
}
