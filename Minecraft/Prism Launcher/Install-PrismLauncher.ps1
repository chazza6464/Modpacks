$ProgressPreference = "SilentlyContinue"
$ErrorActionPreference = "SilentlyContinue"

Clear-Host
Write-Host "Downloading Prism Launcher..." -ForegroundColor Cyan

Invoke-WebRequest -Uri https://github.com/PrismLauncher/PrismLauncher/releases/download/6.3/PrismLauncher-Windows-MSVC-Setup-6.3.exe -OutFile $env:TEMP\PrismLauncherSetup.exe
& $env:TEMP\PrismLauncherSetup.exe

Write-Host "Download complete!" -ForegroundColor Green
Write-Host "Please click Next through the installer."

Write-Host ""
$Java = Read-Host "Would you like to install Java? (installs open-source Java) Y/[N]"
$Uninstall = Read-Host "Would you like to uninstall all currently installed Oracle Java versions? (recommended) Y/[N]"

if ($Uninstall -like "y") {
    # Locate Java
    $RegUninstallPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    )
    
    # Stop Processes
    Get-CimInstance -ClassName "Win32_Process" | Where-Object { $_.ExecutablePath -like "*Program Files\Java*" } | Select-Object @{ n = "Name"; e = { $_.Name.Split(".")[0] }} | Stop-Process -Force
    Get-Process -Name *iexplore* | Stop-Process -Force

    # Uninstall Java
    $UninstallSearchFilter = {($_.GetValue('DisplayName') -like '*Java*') -and (($_.GetValue('Publisher') -eq 'Oracle Corporation'))}
    foreach ($Path in $RegUninstallPaths) {
        if (Test-Path $Path) {
            Get-ChildItem $Path | Where-Object $UninstallSearchFilter | ForEach-Object { Start-Process "C:\Windows\System32\msiexec.exe" "/X$($_.PSChildName) /qn" -Wait}
        }
    }
    
    # Remove Java Remnants
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    $ClassesRootPath = "HKCR:\Installer\Products"
    Get-ChildItem $ClassesRootPath | 
        Where-Object { ($_.GetValue('ProductName') -like '*Java*')} | ForEach-Object {
        Remove-Item $_.PsPath -Force -Recurse
    }

    $JavaSoftPath = 'HKLM:\SOFTWARE\JavaSoft'
    if (Test-Path $JavaSoftPath) {
        Remove-Item $JavaSoftPath -Force -Recurse
    }

    Write-Host "All Oracle Java versions have been removed." -ForegroundColor Green
}

if ($Java -like "y") {
    winget install AdoptOpenJDK.OpenJDK.8 | Out-Null
    winget install Microsoft.OpenJDK.17 | Out-Null
    
    Write-Host "Open-Source versions of Java 8 and Java 17 have been installed." -ForegroundColor Green
}
Read-Host "Press ENTER to close"
Remove-Item $env:TEMP\PrismLauncherSetup.exe
