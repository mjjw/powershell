# Master script
$filepath = "C:\Users\MW5\Desktop"
Write-Host "Converting Binaries to Text"
& $filepath\bin2txt.ps1

sleep 240

Write-Host "Converting Text to Binaries"
& $filepath\txt2bin.ps1

sleep 360

Write-Host "Building VFP Project"
& $filepath\buildvfp.ps1