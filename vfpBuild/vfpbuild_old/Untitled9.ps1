# Function copies all files from subdirectories to root directory
function Copy-Data {
        param($source, $dest)
        $counter = 0
        #If you need to exclude $files = Get-ChildItem $source -Exclude "VSSVER.SCC","*.PJM","*.VCA","*.SCA","*.MNA","*.FRA" -Force -Recurse
        $files = Get-ChildItem $source -Force -Recurse
        foreach($file in $files)
                {
                $status = "Copying file {0} of {1}: {2}" -f $counter, $files.count, $file.name
                Write-Progress -Activity "Copying Files" -Status $status -PercentComplete ($counter/$files.count * 100)
                Copy-Item $file.pspath $dest -Force
                $counter++
                }
}

# Remember to make sure you have full priveleges for folder access of source and destination
# Delete source folder if it exists, mkdir, and copy items: source, nuget.exe

$folderDest = "C:\Users\MW5\Desktop\parts\"
$folderFoxProFfcSrc = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Ffc\"
$folderFoxProFfcDest = "C:\Users\MW5\Documents\Visual FoxPro Projects\"
$folderVFPProject = "\\nylimrps-dev\newparts\Develop\SRC\KS3\CopyofNewparts\*"
$VFPexe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" 

$folderNugetCmd = "C:\Users\MW5\Downloads\nuget.exe"
$nugetServer = "https://rps-octopus/nuget/packages"
$apiKey = "9KCPAOCPXPKPPZMRU6KIL1SHA"

if(Test-Path -Path $folderDest){
    Get-ChildItem $folderDest -Recurse -Force | Remove-Item -Recurse -Force
}

md C:\Users\MW5\Desktop\parts
copy-data $folderVFPProject C:\Users\MW5\Desktop\parts