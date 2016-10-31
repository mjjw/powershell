<# Function to copy the VFP project folder with copy status indicator
Remove all traces of Visual SourceSafe from project
1) Delete all VSSVER.SCC files from the project directory
2) Delete the following files from project directory:
   *.PJM    Project files
   *.VCA    Class files
   *.SCA    Form files
   *.MNA    Menu files
   *.FRA    Report files
3) Remove SCCDATA from project file
   - Open the project file (PJX) as a table using the WINDOW, DATA SESSION command. 
   - Find the SCCDATA column, it should have memo field data for every object
   - Delete all the memo fields in the SCCDATA column #>

<# Function copies all files from subdirectories to root directory
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
}#>

# Remember to make sure you have full priveleges for folder access of source and destination
# Delete source folder if it exists, mkdir, and copy items: source, nuget.exe

$folderDest = "C:\Users\MW5\Desktop\CopyofNewParts-DevOps\"
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
mkdir -f $folderDest
cp -r -fo $folderVFPProject $folderDest
cp $folderNugetCmd $folderDest

# Copy FoxPro Foundation Classes (Ffc) from local VFP Install to Project Folder and Home Directory

cp -r -fo $folderFoxProFfcSrc $folderFoxProFfcDest

<# Here’s the part of the script that finds where VFP is located by looking 
in the Windows Registry (I could have hard-coded the path but this is more flexible)
and running it. Note that output is piped to Out-Null, which forces PowerShell to 
wait until BuildProject.prg is done and VFP terminates. #>

#$regEntry = Get-ItemProperty –Path Registry::HKEY_CLASSES_ROOT\Visual.FoxPro.Application.9\shell\open\command
#$value = $regEntry.'(default)'
#$file = $value.Substring(1, $value.IndexOf('"', 2) - 1)
#$VFPexe = Get-ChildItem $file

# Create Build commands files FPW and PRG in project folder

cd $folderDest

$prg1 = 'Modify Project ' + $folderDest + 'partsplus.pjx Nowait'
$prg2 = "_vfp.Projects('partsplus.pjx').Build(" + $folderDest + 'partsplus.exe")'
$prg3 = 'Quit'

$prg1 > 'build.prg'
$prg2 >> 'build.prg'
$prg3 >> 'build.prg'

$fpw1 = 'screen=off'
$fpw2 = 'command = do "' + $folderDest + 'build.prg"'

$fpw1 > 'build.fpw'
$fpw2 >> 'build.fpw'

$buildConfig = "-c" + $folderDest + "build.fpw" 
& $VFPexe -t $buildConfig | Out-Null

sleep 3

# Get rid of registry error message 
# I was told this is a routine error and I should ignore it

$pinvokes = @'
  [DllImport("user32.dll", CharSet=CharSet.Auto)]
  public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

  [DllImport("user32.dll")]
  [return: MarshalAs(UnmanagedType.Bool)]
  public static extern bool SetForegroundWindow(IntPtr hWnd);
'@

Add-Type -AssemblyName System.Windows.Forms
Add-Type -MemberDefinition $pinvokes -Name NativeMethods -Namespace MyUtils

$hwnd = [MyUtils.NativeMethods]::FindWindow("vfp994000002", "Project Error")
if ($hwnd)
{
    [MyUtils.NativeMethods]::SetForegroundWindow($hwnd)
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}

C:\CopyofNewParts-DevOps\nuget.exe spec
C:\CopyofNewParts-DevOps\nuget.exe pack
C:\CopyofNewParts-DevOps\nuget.exe push -Source $nugetServer Package.1.0.0.nupkg $apiKey