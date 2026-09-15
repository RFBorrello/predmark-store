param([string]$Path = "C:\", [int]$Top = 20)
Get-ChildItem $Path -Recurse -File -ErrorAction SilentlyContinue |
  Sort-Object Length -Descending |
  Select-Object -First $Top @{n='MB';e={[math]::Round($_.Length/1MB,1)}}, FullName |
  Format-Table -AutoSize
