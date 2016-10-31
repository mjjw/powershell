$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe checkout addloanpayback.vc2 /login:mw5

# Get Workspace(s) for Users
$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
&$exe workspaces /owner:mw5 /computer:* /collection:http://rps-tfs:8080/tfs/CodeBaseCollection

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe get

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe checkin test.txt

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe add test.txt /workspace:RPS-DEVX09 /login:nylimrps.jhrps.local\mw5

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe add test.txt /workspace:RPS-DEVX09 /login:mw5

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe status /server:http://rps-tfs:8080/tfs/CodeBaseCollection/VFP /login:nylimrps\mw5

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe add test.txt /workspace:RPS-DEVX09 /login:nylimrps.jhrps.local\mw5

$exe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Ide\TF.exe'
cd C:\Code\VFP\VRSCOM9
&$exe add "New Text Document.txt" "$/VFP/VRSCOM9/"