clear

# Remember to make sure you have full priveleges for folder access of source and destination
# Delete source folder if it exists, mkdir, and copy items: source, nuget.exe

$folderDest = "C:\Users\MW5\Desktop\CopyofNewParts-DevOps\"
$folderFoxProFfcSrc = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Ffc\setobjrf.prg"
$folderFoxProFfcDest = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\"
$folderVFPProject = "\\nylimrps-dev\newparts\Develop\SRC\KS3\CopyofNewparts\*"
$fpw = "C:\Users\MW5\Desktop\build.fpw"
$prg = "C:\Users\MW5\Desktop\build.prg"
$VFPexe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\" 
$folderNugetCmd = "C:\Users\MW5\Downloads\nuget.exe"
$nugetServer = "https://rps-octopus/nuget/packages"
$apiKey = "9KCPAOCPXPKPPZMRU6KIL1SHA"

# if(Test-Path -Path $folderDest){
#     Get-ChildItem $folderDest -Recurse -Force | Remove-Item -Recurse -Force
# }
# mkdir -f $folderDest
# cp -r -fo $folderVFPProject $folderDest
# cp $folderNugetCmd $folderDest

# Copy FoxPro Foundation Classes (Ffc) from local VFP Install to Project Folder and Home Directory

# cp -r -fo $folderFoxProFfcSrc $folderFoxProFfcDest

# Copy FoxPro Config File FPW and PRG

# cp $fpw $folderDest
# cp $prg $folderDest

# Start background process to cancel vfp registry error
# I was told to ignore this registry error 

Start-Job -FilePath "C:\Users\MW5\Desktop\cancelregerror.ps1"

# Run VFP build command with FPW reference to PRG



cd $VFPexe
$buildConfig = "-c" + $folderDest + "build.fpw" 
#.\vfp9.exe -t $buildConfig | Out-Null
.\vfp9.exe -t $buildConfig | Out-Null

# Stop background process

Stop-Job -State Running

sleep 20
# & C:\Users\mw5\Desktop\CopyofNewParts-DevOps\partsplus.exe

# Push exe to Nuget Server in Octopus Deploy

# C:\CopyofNewParts-DevOps\nuget.exe spec
# C:\CopyofNewParts-DevOps\nuget.exe pack
# 
C:\CopyofNewParts-DevOps\nuget.exe push -Source $nugetServer Package.1.0.0.nupkg $apiKey