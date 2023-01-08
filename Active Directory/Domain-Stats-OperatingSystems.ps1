# https://github.com/DarrenRainey/qsdt/
# Displays the total number of devices sorted by operating system from the domain.

Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name,Count
