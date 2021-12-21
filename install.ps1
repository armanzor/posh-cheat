# Create bin folder in user frofile folder
# Add path to path environment variable
$folderName = ".local\bin"
$folderPath = "$env:USERPROFILE\$folderName"
$scriptName = ".\tldr.ps1"
$pathArray = $env:Path | ForEach-Object -MemberName Split -ArgumentList ";"
if (!(Test-Path $folderPath)) {
    Write-Host "Creaing folder $folderPath"
    New-Item -itemType Directory -Path $folderPath
} else {
    Write-Host "Folder $folderPath already exists"
}
if (!(Test-Path $folderPath\$scriptName)) {
    Write-Host "Copying file $scriptName to $folderName"
    Copy-Item -Path $scriptName -Destination $folderPath
} else {
    Write-Host "File $scriptName is already exists in path $folderPath"
}
if (!($folderPath -in $pathArray)) {
    $env:Path += ";$folderPath"
    $profileLine = '$env:Path += ' + "`";$folderPath`""
    if (!(Test-Path -Path $PROFILE)) {
        Write-Host "Create user profile"
        New-Item -ItemType File -Path $PROFILE -Force
        Write-Host "Add variable to user profile"
        Add-Content -Path $PROFILE -Value $profileLine
    } else {
        Add-Content -Path $PROFILE -Value $profileLine
        Write-Host "Add variable to user profile"
    }
} else {
    Write-Host "Path $folderPath is already in user's Path variable"
}
