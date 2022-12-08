powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/chazza6464/Modpacks/main/Update-FTBChocolate.ps1 -OutFile .\Update-FTBChocolate.ps1" & cls
powershell.exe -ExecutionPolicy Bypass -File .\Update-FTBChocolate.ps1
pause