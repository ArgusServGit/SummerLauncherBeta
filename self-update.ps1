# Get the directory of the script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

# Function to unpack package and move files
function UnpackPackageAndMoveFiles {
    $selfUpdateDirectory = Join-Path -Path $scriptDir -ChildPath "self-update"
    $packageFile = "package.tar.gz"
    if (-not (Test-Path $selfUpdateDirectory)) {
        New-Item -ItemType Directory -Path $selfUpdateDirectory | Out-Null
    }
    tar -xzf $packageFile -C $selfUpdateDirectory
    Remove-Item $packageFile -Force
    Get-ChildItem -Path $selfUpdateDirectory -Recurse | Move-Item -Destination $scriptDir -Force
    Remove-Item $selfUpdateDirectory -Recurse -Force
}

# Function to start the application
function StartApp {
    Start-Process -FilePath $executablePath
}

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Call the function to unpack package and move files
UnpackPackageAndMoveFiles

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Call the function to start the application
StartApp
