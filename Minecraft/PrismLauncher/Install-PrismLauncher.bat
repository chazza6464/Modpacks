powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/chazza6464/Modpacks/main/PrismLauncher/Install-PrismLauncher.ps1 -OutFile .\Install-PrismLauncher.ps1" & cls
powershell.exe -ExecutionPolicy Bypass -STA -File .\Install-PrismLauncher.ps1
DEL .\Install-PrismLauncher.ps1
pause
