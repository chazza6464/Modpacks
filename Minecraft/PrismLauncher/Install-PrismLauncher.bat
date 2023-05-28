powershell.exe -Command "Invoke-WebRequest -Uri https://github.com/chazza6464/Modpacks/raw/main/Minecraft/PrismLauncher/Install-PrismLauncher.ps1 -OutFile .\Install-PrismLauncher.ps1" & cls
powershell.exe -ExecutionPolicy Bypass -STA -File .\Install-PrismLauncher.ps1
DEL .\Install-PrismLauncher.ps1
pause
