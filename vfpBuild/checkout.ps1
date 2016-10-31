Write-Host "Converting Text to Binaries"
$job = Start-Job -FilePath $filepath\txt2bin.ps1
Wait-Job $job

Receive-Job $job

Write-Host "Building VFP Project"
& $filepath\buildvfp.ps1
