# https://github.com/DarrenRainey/qsdt/
# Gets all users how have open files on the current SMB file server.
function getHost($ip){
	try{
	return [System.Net.Dns]::GetHostEntry($ip).HostName
	} catch {}
}

Get-SmbOpenFile | select ClientComputerName,ClientUsername -Unique| % {new-object psobject -property @{Username=$_.ClientUsername; IP=$_.ClientComputerName; Host=(getHost($_.ClientComputerName))} }
