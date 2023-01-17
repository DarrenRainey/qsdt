# https://github.com/DarrenRainey/qsdt
# This function will get all open files on the remote pc and display then in a nice grid gui for easy search/filtering.
function getOpenFiles($remotePC){
	openfiles /Query /S $remotePC /FO CSV /V | ConvertFrom-Csv | Out-GridView
}
