# Alternative version of clearPrinters using WMIC and PSService to restart services
# For when PS Remoting is disabled.
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
#(GWMI -Class Win32_Printer -ComputerName $remotePC -Filter "name LIKE '$selection'").cancelalljobs()
$pf =  "`"name LIKE '%$clearPrinter%'`""
#echo $pf
WMIC.exe /node:$remotePCiP printjob where $pf DELETE

if($menu.count -eq 0){
	echo "No printers in an error state"
	break;
}

echo "Restarting Services"
#Get-Service -ComputerName $remotePC -Name spooler | Restart-Service -Force
.\PsService.exe \\$remotePC -u admin\drainey restart spooler

echo "All print jobs should be cleared / Print spooler restarted"
Set-Clipboard "Print queue cleared for $selection"
}
