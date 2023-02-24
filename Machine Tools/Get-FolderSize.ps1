# https://github.com/DarrenRainey/qsdt/ - Sort all folders in current directory by size.

function Get-FolderSize ($Path) {
  if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
  $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
  $Sum = '{0:N2}' -f ($Measure.Sum / 1Gb)
  [PSCustomObject]@{
  "Path" = $Path
  "Size(GB)" = $Sum
  }
 }
}

Get-ChildItem . | foreach {
	Get-FolderSize $_.Name
} |Sort-Object "Size(GB)" -Descending
