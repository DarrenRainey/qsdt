# https://github.com/DarrenRainey/qsdt
# Attempts to retrieve the MAC address/serial number for all printers via ARP table cache on the current machine.
GWMI -Class WIN32_Printer | Where-Object {$_.Location -ne $null} | % {new-object psobject -property @{Printer=$_.Name; IP=$_.Location; MAC=(Get-NetNeighbor -IPAddress $_.Location)} }
