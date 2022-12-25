# Update Pixelmon #

# Stage Zero - Setup
$ErrorActionPreference = "SilentlyContinue"
Add-Type -AssemblyName System.Windows.Forms

# Stage One - Identify Instance Folder
Clear-Host
Write-Host "Stage One - Attempting to locate Pixelmon instance folder..." -ForegroundColor Cyan
if (Test-Path "$env:USERPROFILE\Desktop\MultiMC\Instances") {
    $Folders = Get-ChildItem -Path "$env:USERPROFILE\Desktop\MultiMC\Instances" -Directory
    foreach ($Folder in $Folders) {
        if (Get-Content -Path "$env:USERPROFILE\Desktop\MultiMC\Instances\$($Folder.Name)" -like "*Pixelmon*") {
            $InstancePath = "$env:USERPROFILE\Desktop\MultiMC\Instances\$($Folder.Name)\minecraft"
            Write-Host "Found existing Pixelmon instance!" -ForegroundColor Green
            break
        }
    }
} else {
    Write-Host "Could not find MultiMC or Pixelmon in the standard location." -ForegroundColor Yellow
    $Picker = New-Object System.Windows.Forms.FolderBrowserDialog
    $Picker.Description = "Select the MultiMC folder"
    $Picker.InitialDirectory = "$env:USERPROFILE\Desktop"
    $Picker.TopMost = $true
    
    if ($Picker.ShowDialog() -eq "OK") {
        $InstancePath = $Picker.SelectedPath
    } else {
        Write-Host "Couldn't load the folder picker dialog." -ForegroundColor Red
        Write-Host "Please find the instance folder path and paste the file path below:"
        $InstancePath = Read-Host "Instance Folder Path"
    }
    
}

# Stage Two - Install mods
Write-Host "`nStage Two - Installing additional mods to Pixelmon..." -ForegroundColor Cyan

# Create
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/create-mc1.16.5_v0.3.2g.jar" -OutFile "$InstancePath\Mods\create-mc1.16.5_v0.3.2g.jar"
Write-Host "(1/5) Downloaded Create" -ForegroundColor Yellow

# Flywheel
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/flywheel-1.16-0.2.5.jar" -OutFile "$InstancePath\Mods\flywheel-1.16.0.2.5.jar"
Write-Host "(2/5) Downloaded Flywheel" -ForegroundColor Yellow

# JEI
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/jei-1.16.5-7.7.1.153.jar" -OutFile "$InstancePath\Mods\jei-1.16.5-7.7.1.153.jar"
Write-Host "(3/5) Downloaded JEI" -ForegroundColor Yellow

# OreExcavation
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/OreExcavation-1.8.157.jar" -OutFile "$InstancePath\Mods\OreExcavation-1.8.157.jar"
Write-Host "(4/5) Downloaded OreExcavation" -ForegroundColor Yellow

# Simple Storage Network
Invoke-WebRequest -Uri "https://github.com/chazza6464/Modpacks/raw/main/Mod%20Files/SimpleStorageNetwork-1.16.5-1.5.2.jar" -OutFile "$InstancePath\Mods\SimpleStorageNetwork-1.16.5-1.5.2.jar"
Write-Host "(5/5) Downloaded Simple Storage Network" -ForegroundColor Yellow

Write-Host "All mods and updates have been downloaded to the Pixelmon mod!" -ForegroundColor Green
Write-Host "You should now be able to reload the modpack from MultiMC."

#=====#
function Get-MultiMC {
    $Picker = New-Object System.Windows.Forms.FolderBrowserDialog
    $Picker.Description = "Select the MultiMC folder"
    $Picker.InitialDirectory = "$env:USERPROFILE\Desktop"
    $Picker.TopMost = $true
    
    if ($Picker.ShowDialog() -eq "OK") {
        $Folder += $Picker.SelectedPath
    }
    return $Folder
}