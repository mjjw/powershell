$hwnd = Invoke-Win32 "user32.dll" ([IntPtr]) "FindWindow" @([String],[String]) @($null, "Pject Error")
if (Invoke-Win32 "user32.dll" ([bool]) "SetForegroundWindow" @([IntPtr]) @($hwnd) -eq 0)
{
Invoke-Win32 "kernel32.dll" ([int]) "GetLastError" @() @()
return
}

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")