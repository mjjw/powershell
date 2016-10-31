	
Start-Process calc.exe

$pinvokes = @'
  [DllImport("user32.dll", CharSet=CharSet.Auto)]
  public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

  [DllImport("user32.dll")]
  [return: MarshalAs(UnmanagedType.Bool)]
  public static extern bool SetForegroundWindow(IntPtr hWnd);
'@

Add-Type -AssemblyName System.Windows.Forms
Add-Type -MemberDefinition $pinvokes -Name NativeMethods -Namespace MyUtils

$hwnd = [MyUtils.NativeMethods]::FindWindow("CalcFrame", "Calculator")
if ($hwnd)
{
    [MyUtils.NativeMethods]::SetForegroundWindow($hwnd)
    [System.Windows.Forms.SendKeys]::SendWait("6")
    [System.Windows.Forms.SendKeys]::SendWait("*")
    [System.Windows.Forms.SendKeys]::SendWait("7")
    [System.Windows.Forms.SendKeys]::SendWait("=")
}