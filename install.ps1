# Create bin folder in user frofile folder
# Add path to path environment variable
$folderName = "bin"
$folderPath = "$env:USERPROFILE\$folderName"
$registryKey = "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment"
$scriptName = ".\tldr.ps1"
$pathArray = $env:Path | ForEach-Object -MemberName Split -ArgumentList ";"
if (!(Test-Path $folderPath)) {
    New-Item -itemType Directory -Path $folderPath
}
if (!($folderPath -in $pathArray)) {
    $oldPath = (Get-ItemProperty -Path $registryKey -Name Path).Path
    $newPath = "$oldPath;$folderPath"
    Set-ItemProperty -Path $registryKey -Name Path -Value $newPath
    $env:Path += ";$folderPath"
}
if (!(Test-Path $folderPath\$scriptName)) {
    Copy-Item -Path $scriptName -Destination $folderPath
}
