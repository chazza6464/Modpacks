#########################################
# Update specific mods in FTB Chocolate #
#########################################

# Stage Zero - Setup
$ErrorActionPreference = "SilentlyContinue"

# Stage One - Identify Instance Folder
Write-Host "Stage One - Attempting to locate FTB Chocolate instance folder..." -ForegroundColor Cyan
if (Test-Path "$env:LOCALAPPDATA\.ftba\Instances") {
    $Folders = Get-ChildItem -Path "$env:LOCALAPPDATA\.ftba\Instances" -Directory
    foreach ($Folder in $Folders) {
        if ((Get-Content -Path "$env:LOCALAPPDATA\.ftba\Instances\$($Folder.Name)\instance.json") -like "*FTB Chocolate*") {
            $global:InstancePath = "$env:LOCALAPPDATA\.ftba\Instances\$($Folder.Name)"
            Write-Host "Found existing FTB Chocolate instance!" -ForegroundColor Green
            Break
        }
    }
} else {
    Write-Warning "The modpack is not installed in the standard location."
    Write-Host "Please find the instance folder path and paste the file path below:"
    $global:InstancePath = Read-Host "Instance Folder Path"
}


# Stage Two - Update/Install mods
Write-Host "`nStage Two - Updating existing mods in FTB Chocolate..." -ForegroundColor Cyan

# Create
# Disable 0.4, Install 0.5
Rename-Item -Path "$global:InstancePath\Mods\create-mc1.18.2_v0.4.1.jar" -NewName "$global:InstancePath\Mods\create-mc1.18.2_v0.4.1.disabled"
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/create-1.18.2-0.5.0.e.jar" -OutFile "$global:InstancePath\Mods\create-1.18.2-0.5.0.e.jar"
Write-Host "(1/7) Downloaded Create" -ForegroundColor Yellow

# Flywheel
# Disable 0.6.2, Install 0.6.5
Rename-Item -Path "$global:InstancePath\Mods\flywheel-forge-1.18-0.6.2.jar" -NewName "$global:InstancePath\Mods\flywheel-forge-1.18-0.6.2.jar.disabled"
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/flywheel-forge-1.18.2-0.6.5.jar" -OutFile "$global:InstancePath\Mods\flywheel-forge-1.18.2-0.6.5.jar"
Write-Host "(2/7) Downloaded Flywheel" -ForegroundColor Yellow

# Chipped
# Install 2.0.0
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/chipped-2.0.0-forge.jar" -OutFile "$global:InstancePath\Mods\chipped-2.0.0-forge.jar"
Write-Host "(3/7) Downloaded Chipped" -ForegroundColor Yellow

# ConnectedTextures Mod
# Install 1.1.5
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/CTM-1.18.2-1.1.5+5.jar" -OutFile "$global:InstancePath\Mods\CTM-1.18.2-1.1.5+5.jar"
Write-Host "(4/7) Downloaded ConnectedTextures" -ForegroundColor Yellow


# OpenBlocks Elevator
# Install 1.8.4
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/elevatorid-1.18.2-1.8.4.jar" -OutFile "$global:InstancePath\Mods\elevatorid-1.18.2-1.8.4.jar"
Write-Host "(5/7) Downloaded OpenBlocks Elevator" -ForegroundColor Yellow

# Iron Chests
# Install 13.2.11
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/ironchest-1.18.2-13.2.11.jar" -OutFile "$global:InstancePath\Mods\ironchest-1.18.2-13.2.11.jar"
Write-Host "(6/7) Downloaded Iron Chests" -ForegroundColor Yellow

# FTB Ultimine
# Install 1802.3.3
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/ftb-ultimine-forge-1802.3.3-build.67.jar" -OutFile "$global:InstancePath\Mods\ftb-ultimine-forge-1802.3.3-build.67.jar"
Write-Host "(7/7) Downloaded FTB Ultimine" -ForegroundColor Yellow

Write-Host "All mods and updates have been downloaded to the FTB App!" -ForegroundColor Green
Write-Host "`nThe FTB App will no longer load the modpack, we need to use MultiMC to update Minecraft Forge next." -ForegroundColor Cyan


# Stage Three - MultiMC installation
Write-Host "`nStage Three - Downloading and extracting MultiMC..." -ForegroundColor Cyan

Invoke-WebRequest -Uri "https://files.multimc.org/downloads/mmc-stable-win32.zip" -OutFile "$env:USERPROFILE\Downloads\MultiMC.zip"

if (-not(Test-Path $env:USERPROFILE\Desktop)) {
    Write-Host "Unable to find the Desktop folder. Is OneDrive Folder Backup enabled?" -ForegroundColor Yellow
    Write-Host "Enter the folder path to extract MultiMC to:"
    $Path = Read-Host "Use Shift+Insert to paste into this box"
    Expand-Archive -Path "$env:USERPROFILE\Downloads\MultiMC.zip" -DestinationPath $Path
} else {
    Expand-Archive -Path "$env:USERPROFILE\Downloads\MultiMC.zip" -DestinationPath "$env:USERPROFILE\Desktop"
}
Write-Host "MultiMC has been extracted." -ForegroundColor Green

Write-Host "`nTo add FTB Chocolate to MultiMC:" -ForegroundColor Cyan
Write-Host "1: Open MultiMC and choose British English."
Write-Host "2: Select the recommended Java version (the one with the star)."
Write-Host "3: Choose to enable or disable analytics (up to you)."
Write-Host "4: Click 'Add Instance in the top left corner, and select 'FTB App Import'."
Write-Host "5: Choose FTB Chocolate from the menu on the right, and choose OK."
Write-Host "6: Select FTB Chocolate and click Launch on the right hand side."
Write-Host "7: Add your Microsoft account that you use to play Minecraft."
