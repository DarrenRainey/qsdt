<#
  Darren Rainey 09/07/2024 - Change Power Plan.ps1

  Example below sets power plan to "High Performance"

  May need to run as administrator privliages.
#>

$p = Get-CimInstance -Name root\cimv2\power -Class win32_PowerPlan -Filter "ElementName = 'High Performance'"      
powercfg /setactive ([string]$p.InstanceID).Replace("Microsoft:PowerPlan\{","").Replace("}","")
