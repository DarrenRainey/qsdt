# https://github.com/DarrenRainey/qsdt
# Attempts to retrieve the MAC address/serial number for all printers via ARP table cache on the current machine.
Get-Printer |Where-Object {$_.PortName -notlike "WSD*" -and $_.PortName -notlike "PORTPRO*" -and $_.PortName -notlike "USB*" -and $_.PortName -notlike "*FAX*" -and $_.PortName -notlike "*Microsoft*"}| % {new-object psobject -property @{Printer=$_.Name; IP=$_.PortName; MAC=(Get-NetNeighbor -IPAddress $_.PortName).LinkLayerAddress} }
