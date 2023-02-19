# Currently untested but should remove local account / generate a list of current accounts.
$accounts = Get-LocalUser
$menu = @{}
$count = $accounts | Measure-Object
for ($i=1;$i -le $count.count; $i++) 
{ Write-Host "$i. $($accounts[$i-1].name),$($accounts[$i-1].status)" 
$menu.Add($i,($accounts[$i-1].name))}

echo $menu
[int]$ans = Read-Host 'Enter selection'
$selection = $menu.Item($ans)
Remove-LocalUser -Name $selection 
