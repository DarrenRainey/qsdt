# https://github.com/DarrenRainey/qsdt/
# Gets all users how have open files on the current SMB file server.
Get-SmbOpenFile | select ClientComputerName,ClientUsername -Unique
