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
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

sleep 10
If ($hwnd)
{
    [MyUtils.NativeMethods]::SetForegroundWindow($hwnd)
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}

sleep 10
If ($hwnd)
{
    [MyUtils.NativeMethods]::SetForegroundWindow($hwnd)
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}