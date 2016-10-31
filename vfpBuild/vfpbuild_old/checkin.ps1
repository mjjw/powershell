Param( 
  [Parameter(Mandatory=$true)]
  [string]$workSpacePath, 
  [Parameter(Mandatory=$true)]
  [string]$projectCollection,
  [string]$WorkingDirectory= $Env:TF_BUILD_BUILDDIRECTORY,
  [string]$DF = $Env:TF_BUILD_DROPLOCATION
)
Try
{
#
# Get the TeamFoundation PowerShell cmdlets 
#
    Add-PSSnapin Microsoft.TeamFoundation.Powershell
# Identify the server (might be a better way for this)
    $tfsServerString = ("http://rps-tfs/8080/tfs/" + $projectCollection)
    $tfs = get-tfsserver $tfsServerString
    Write-Host ("tfs = " + $tfs)
 
    Write-Host ("drop folder = " + $DF)
    Write-Host ("workspace path = " + $workSpacePath)
    Write-Host ("working directory = " + $WorkingDirectory)
 
# The TF.exe command, since the New_TfsChangeset doesn't work properly
    $tfexe = 'C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\TF.exe'
    
    # Construct the full workspace from the working directory + "\src" and the work space path.
    # In TFS 2010, "src" was "source". 
    # Now it's "src". That's pretty important.
	Write-Host "Get TFS Workspace"
	$wsp = $WorkingDirectory + "\src" + $workSpacePath
    Write-Host ("wsp = " + $wsp)
    
    Write-Host "Copy the DLLs from the drop folder to workspace folder"
    Copy-Item -LiteralPath $DF -Include "*.dll" -Destination $wsp 
 
    # Create the Pending Change, and use the -Edit option 
    # - we're replacing existing binaries, nothing else.
    Write-Host "Add-TfsPendingChange"
    Add-TfsPendingChange -Edit -Item $wsp -Recurse
 
    # Check in the Pending Change. New-TfsChangeset doesn't work, so we're dropping down to TF.exe.
    Try
    {
        Write-Host "tf.exe checkin"
        & $tfexe checkin $wsp /comment:"***NO_CI***" 
        /bypass /noprompt /recursive /override:"Auto-Build: Version Update" | Out-Null
    }
    Catch [system.exception] 
    {
        Write-Host "caught the exception. Continuing."
    }
 
	Write-Host "Binaries checked in."
	Write-Host "Done!"
    exit 0
}
Catch {
	Write-Error $_
	exit 1
}