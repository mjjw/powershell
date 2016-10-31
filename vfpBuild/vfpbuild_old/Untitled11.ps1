Add-PSSnapin Microsoft.TeamFoundation.PowerShell

$serverUrl = "http://rps-tfs:8080/tfs/CodeBaseCollection/"
$tfsServer = Get-TfsServer -Name $serverUrl

# Output some information about the server object
$tfsServer

