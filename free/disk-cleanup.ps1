param([switch]$Delete)
$rows = @()
foreach ($p in @("$env:TEMP", "$env:WINDIR\Temp", "$env:LOCALAPPDATA\Microsoft\Windows\Explorer")) {
  if (Test-Path $p) { $rows += Get-ChildItem $p -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } }
}
$total = ($rows | Measure-Object Length -Sum).Sum / 1MB
"{0} stale files, {1:N1} MB reclaimable" -f $rows.Count, $total
$rows | Sort-Object Length -Descending | Select-Object -First 10 | Format-Table Name, @{n='MB';e={[math]::Round($_.Length/1MB,1)}} -AutoSize
if ($Delete) { $rows | Remove-Item -Force -ErrorAction SilentlyContinue; "Deleted." } else { "Dry run only. Use -Delete to remove." }
