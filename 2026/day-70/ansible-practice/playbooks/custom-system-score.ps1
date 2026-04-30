Write-Host "Custom Windows System Score" -ForegroundColor Cyan
Write-Host "==========================="

$cpu = Get-CimInstance Win32_Processor
$ram = Get-CimInstance Win32_ComputerSystem
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

# CPU Score
$cpuCores = $cpu.NumberOfCores
$cpuThreads = $cpu.NumberOfLogicalProcessors
$cpuSpeed = $cpu.MaxClockSpeed

$cpuScore = [math]::Min(10, (($cpuCores * 1.5) + ($cpuThreads * 0.5) + ($cpuSpeed / 1000)) / 2)

# RAM Score
$totalRamGB = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
$ramScore = [math]::Min(10, $totalRamGB / 4)

# Disk Score
$totalDiskGB = [math]::Round($disk.Size / 1GB, 2)
$freeDiskGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$freePercent = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2)

$diskScore = [math]::Min(10, $freePercent / 10)

# Final Score
$finalScore = [math]::Round((($cpuScore + $ramScore + $diskScore) / 3), 2)

Write-Host ""
Write-Host "CPU:" -ForegroundColor Yellow
Write-Host "Name: $($cpu.Name)"
Write-Host "Cores: $cpuCores"
Write-Host "Threads: $cpuThreads"
Write-Host "Max Speed: $cpuSpeed MHz"
Write-Host "CPU Score: $([math]::Round($cpuScore, 2)) / 10"

Write-Host ""
Write-Host "Memory:" -ForegroundColor Yellow
Write-Host "RAM: $totalRamGB GB"
Write-Host "RAM Score: $([math]::Round($ramScore, 2)) / 10"

Write-Host ""
Write-Host "Disk C:" -ForegroundColor Yellow
Write-Host "Total: $totalDiskGB GB"
Write-Host "Free: $freeDiskGB GB"
Write-Host "Free Space: $freePercent%"
Write-Host "Disk Score: $([math]::Round($diskScore, 2)) / 10"

Write-Host ""
Write-Host "==========================="
Write-Host "Final Custom System Score: $finalScore / 10" -ForegroundColor Green