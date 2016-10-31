$foxbin2prg = "C:\Users\MW5\Desktop\foxbin2prg\foxbin2prg.exe"
$newparts = "C:\Users\MW5\Desktop\CopyofNewParts-DevOps"

# Currently supports the conversion between PJX,SCX,VCX,FRX,LBX,DBC,DBF and MNX 
# files, for which a TEXT version is generated with PJ2,SC2,VC2,FR2,LB2,DC2,DB2 
# and MN2 extensions, and can be reconfigured to be compatible with SCCAPI 
# (just tested with SourceSafe).

cd $newparts

# If you want to convert all pjx projects: 
# Get-ChildItem $newparts -include *.pjx -recurse | foreach ($_) {& $foxbin2prg $_.fullname "*"}
& $foxbin2prg $newparts\partsplus.pjx "*"