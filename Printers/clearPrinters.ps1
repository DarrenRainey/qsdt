# This function will get all print jobs on a remote pc/server
# and allow the admin to clear any printers with jammed jobs
# as well as restart the print spooler service
# usage: clearPrinter myserver.local

function clearPrinter($remotePC){
$printers =  Get-Printer -ComputerName $remotePC |  Where-Object {$_.jobcount -ne 0}

$menu = @{}
$count = $printers | Measure-Object
for ($i=1;$i -le $count.count; $i++) 
{ Write-Host "$i. $($printers[$i-1].name),$($printers[$i-1].status)" 
$menu.Add($i,($printers[$i-1].name))}

if($menu.count -eq 0){
	echo "No print jobs waiting"
	break;
}
[int]$ans = Read-Host 'Enter selection'
$selection = $menu.Item($ans) ; $printJob = Get-PrintJob -PrinterName $selection  | Remove-PrintJob
Get-Service -ComputerName $remotePC -Name spooler | Restart-Service -Force
echo "All print jobs should be cleared / Print spooler restarted"
Set-Clipboard "Print queue cleared for $selection"
}
