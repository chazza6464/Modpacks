#########################################
# Update specific mods in FTB Chocolate #
#########################################

# Identify FTB Chocolate instance folder
# Update Create to 0.5                          https://www.curseforge.com/minecraft/mc-mods/create/download/4007544
# Update Flywheel to 0.6.5                      https://www.curseforge.com/minecraft/mc-mods/flywheel/download/3934664
# Install Chipped 2.0.0                         https://www.curseforge.com/minecraft/mc-mods/chipped/download/4020976
# Install OpenBlocks Elevator 1.8.4             https://www.curseforge.com/minecraft/mc-mods/openblocks-elevator/download/3670034
# Install Iron Chests 13.2.11                   https://www.curseforge.com/minecraft/mc-mods/iron-chests/download/3966367
# Install FTB Ultimine                          https://www.curseforge.com/minecraft/mc-mods/ftb-ultimine-forge/download/3993576

# Stage Zero - Setup
$ErrorActionPreference = "SilentlyContinue"

# Stage One - Identify Instance Folder
Write-Host "Attempting to locate FTB Chocolate instance folder..." -ForegroundColor Cyan
if (Test-Path "$env:LOCALAPPDATA\.ftba\Instances") {
    $Folders = Get-ChildItem -Path "$env:LOCALAPPDATA\.ftba\Instances" -Directory
    foreach ($Folder in $Folders) {
        if ((Get-Content -Path "$env:LOCALAPPDATA\.ftba\Instances\$($Folder.Name)\instance.json") -like "*FTB Chocolate*") {
            $global:InstancePath = "$env:LOCALAPPDATA\.ftba\Instances\$($Folder.Name)"
            Write-Host "Found FTB Chocolate! Installing/Updating mods..." -ForegroundColor Cyan
            Break
        }
    }
} else {
    Write-Warning "The modpack is not installed in the standard location."
    Write-Host "Please find the instance folder path and paste the file path below:"
    $global:InstancePath = Read-Host "Instance Folder Path"
}


# Stage Two - Update/Install mods

# Create
# Disable 0.4, Install 0.5
Rename-Item -Path "$global:InstancePath\Mods\create-mc1.18.2_v0.4.1.jar" -NewName "$global:InstancePath\Mods\create-mc1.18.2_v0.4.1.disabled"
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/create-1.18.2-0.5.0.e.jar" -OutFile "$global:InstancePath\Mods\create-1.18.2-0.5.0.e.jar"
Write-Host "(1/6) Downloaded Create" -ForegroundColor Yellow

# Flywheel
# Disable 0.6.2, Install 0.6.5
Rename-Item -Path "$global:InstancePath\Mods\flywheel-forge-1.18-0.6.2.jar" -NewName "$global:InstancePath\Mods\flywheel-forge-1.18-0.6.2.jar.disabled"
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/flywheel-forge-1.18.2-0.6.5.jar" -OutFile "$global:InstancePath\Mods\flywheel-forge-1.18.2-0.6.5.jar"
Write-Host "(2/6) Downloaded Flywheel" -ForegroundColor Yellow

# Chipped
# Install 2.0.0
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/chipped-2.0.0-forge.jar" -OutFile "$global:InstancePath\Mods\chipped-2.0.0-forge.jar"
Write-Host "(3/6) Downloaded Chipped" -ForegroundColor Yellow

# OpenBlocks Elevator
# Install 1.8.4
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/elevatorid-1.18.2-1.8.4.jar" -OutFile "$global:InstancePath\Mods\elevatorid-1.18.2-1.8.4.jar"
Write-Host "(4/6) Downloaded OpenBlocks Elevator" -ForegroundColor Yellow

# Iron Chests
# Install 13.2.11
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/ironchest-1.18.2-13.2.11.jar" -OutFile "$global:InstancePath\Mods\ironchest-1.18.2-13.2.11.jar"
Write-Host "(5/6) Downloaded Iron Chests" -ForegroundColor Yellow

# FTB Ultimine
# Install 1802.3.3
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/blob/main/Mod%20Files/ftb-ultimine-forge-1802.3.3-build.67.jar" -OutFile "$global:InstancePath\Mods\ftb-ultimine-forge-1802.3.3-build.67.jar"
Write-Host "(6/6) Downloaded FTB Ultimine" -ForegroundColor Yellow

Write-Host "All mods have been updated or installed. Test out the pack!" -ForegroundColor Green
