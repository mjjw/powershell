Add-PSSnapin Microsoft.TeamFoundation.Powershell
$tfexe = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\TF.exe"
$foxbin2prg = "C:\Users\MW5\Desktop\foxbin2prg\foxbin2prg.exe"
$vfpfile = "C:\Users\MW5\Desktop\CopyofNewParts-DevOps\FORMS\PARTS\clientaccesssupervisor.scx"
$tfworkspace = "C:\Code\VFP\VFP Compilation Scripts"

# Binary File to Text Conversion
& $foxbin2prg $vfpfile 
$vfpfileresult = "C:\Users\MW5\Desktop\CopyofNewParts-DevOps\FORMS\PARTS\clientaccesssupervisor.sc2"
sleep 10

# Add Text File to TFS Workspace
Move-Item -Path $vfpfileresult -Destination $tfworkspace
cd $tfworkspace
& $tfexe add clientaccesssupervisor.sc2 /noprompt
sleep 10

# Check-in file from TFS Workspace
cd $tfworkspace
& $tfexe checkin clientaccesssupervisor.sc2 /comment:"This is a test" /noprompt

# Check-out file from TFS Workspace
cd $tfworkspace
& $tfexe checkout clientaccesssupervisor.sc2 
Move-Item -Path clientaccesssupervisor.sc2 -Destination "C:\Users\MW5\Desktop"

# Text File to Binary Conversion
& $foxbin2prg "C:\Users\MW5\Desktop\clientaccesssupervisor.scx"