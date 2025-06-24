[CmdletBinding()]
param (
    $RepositoryUrl = "https://github.com/chazza6464/Modpacks/raw/refs/heads/main/Stardew%20Valley%20Expanded"
)

$ProgressPreference = "SilentlyContinue"

Clear-Host
Write-Host "+------------------------------------+" -ForegroundColor Yellow
Write-Host "| Installing Stardew Valley Expanded |" -ForegroundColor Yellow
Write-Host "+------------------------------------+" -ForegroundColor Yellow
Start-Sleep -Seconds 2



# Find Stardew Valley install location
Write-Host "[01] Finding your Stardew Valley game folder..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
$StardewRoot = "C:\Program Files (x86)\Steam\steamapps\common\Stardew Valley"
if (Test-Path -Path $StardewRoot) {
    Write-Host "Success! Found your Stardew Valley game at: " -ForegroundColor Green -NoNewline
    Write-Host "$StardewRoot" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
}
else {
    Write-Host "[ERROR] " -ForegroundColor Red -NoNewline
    Write-Host "Could not find your Stardew Valley game. Speak to Zach for troubleshooting. :)"
    Write-Host $_.Exception.Message
    Write-Host "Press Enter to exit."
    Read-Host
    exit
}



# Create mods folder
Write-Host "[02] Creating mods folder..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
if (Test-Path -Path "$StardewRoot\Mods") {
    Write-Host "Success! You already have a Mods folder." -ForegroundColor Green
    $ModsFolder = Get-Item -Path "$StardewRoot\Mods"
}
else {
    try {
        $ModsFolder = New-Item -Path $StardewRoot -Name "Mods" -ItemType Directory
        Write-Host "Success! Created a new Mods folder." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    catch {
        Write-Host "[ERROR] " -ForegroundColor Red -NoNewline
        Write-Host "Could not create your Mods folder. Speak to Zach for troubleshooting. :)"
        Write-Host $_.Exception.Message
        Write-Host "Press Enter to exit."
        Read-Host
        exit
    }
}
# Empty out the existing Mods folder
Get-ChildItem -Path $ModsFolder -Recurse -Force | Remove-Item -Force -Recurse



# Download mod files
Write-Host "[03] Downloading mod files..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
$RequiredMods = @(
    "Content Patcher"
    "Farm Type Manager"
    "Frontier Farm"
    "Grampleton Fields"
    "SMAPI"
    "Stardew Valley Expanded"
)
Write-Host "There are $($RequiredMods.Count) mods to download."
$RequiredMods | ForEach-Object {
    $ModName = "$($_ -replace " ", "%20").zip"
    $URL = "$RepositoryUrl/$ModName"
    Start-Sleep -Seconds 1

    Write-Host "-> Downloading $_..."
    Invoke-WebRequest -Uri $URL -OutFile "$env:TEMP\$ModName"
    Expand-Archive -Path "$env:TEMP\$ModName" -DestinationPath $ModsFolder -Force
    Remove-Item -Path "$env:TEMP\$ModName" -Force
}
Write-Host "Success! All mod files have been downloaded." -ForegroundColor Green
Start-Sleep -Seconds 2



# Install SMAPI
Write-Host "[04] Installing the Stardew Modding API (SMAPI)..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
Write-Host "NOTE: There's some interaction from you here. " -ForegroundColor Yellow -NoNewline
Write-Host "Don't worry, I'll guide you through! :)" -ForegroundColor Green
Start-Sleep -Seconds 3

Write-Host "A second window will open and will guide you through installing this step." -ForegroundColor Cyan
Write-Host "Check this window to see which options you should choose." -ForegroundColor Green
Start-Sleep -Seconds 3

$Installer = "$ModsFolder\SMAPI 4.2.1 installer\internal\windows\SMAPI.Installer.exe"
Start-Process -FilePath $Installer

Write-Host ""
Write-Host ""
Write-Host "------------------"
Write-Host "'Where do you want to add or remove SMAPI?'" -ForegroundColor Cyan
Write-Host "-> Choose: [1] $StardewRoot" -ForegroundColor Green
Write-Host "------------------"
Write-Host "'What do you want to do?'"
Write-Host "-> Choose: [1] Install SMAPI" -ForegroundColor Green
Write-Host "------------------"
Write-Host "Then press Enter on the other window." -ForegroundColor Green
Write-Host "Press Enter back here once you're done."
Read-Host



# Enabling modded achievements in Steam
Write-Host "[05] Enabling Steam achievements in modded Stardew..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
Write-Host "NOTE: Another couple of steps for you to complete here!" -ForegroundColor Green
Start-Sleep -Seconds 2
Write-Host "`t1. Open Steam"
Write-Host "`t2. Go to your Library"
Write-Host "`t3. Right-click Stardew Valley and choose 'Properties'"
Write-Host "`t4. In the box called 'Launch Options', copy and paste the following (include the speech marks too):"
Write-Host "`t`"$StardewRoot\StardewModdingAPI.exe`" %command%" -ForegroundColor Yellow
Write-Host "`t5. Close the Properties box with the X in the top-right"
Start-Sleep -Seconds 5
Write-Host "Press Enter to continue once you've done that."
Read-Host



# Setup completed!
Clear-Host
Write-Host "+------------------------------------+" -ForegroundColor Yellow
Write-Host "| Installing Stardew Valley Expanded |" -ForegroundColor Yellow
Write-Host "+------------------------------------+" -ForegroundColor Yellow
Write-Host ""
Write-Host "----|   INSTALLATION COMPLETED   |----" -ForegroundColor Green
Start-Sleep -Seconds 1
Write-Host "You should now be able to launch Stardew Valley with mods and achievements enabled!" -ForegroundColor Green
Start-Sleep -Seconds 2
Write-Host "Press Enter to close this window."
Read-Host
exit
