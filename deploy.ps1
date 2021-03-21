$version = ((Get-Content "info.json" -Raw) | ConvertFrom-Json).version

Remove-Item -path "$env:APPDATA\Factorio\mods\Filter_Combinator_$version\*" -Force -Recurse
Copy-Item -Path "*" -Destination "$env:APPDATA\Factorio\mods\Filter_Combinator_$version" -PassThru -Force -Recurse -Exclude @(".vs", ".gitignore", "deploy.ps1", "README.md", ".git", "Releases")

$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}

Set-Alias 7zip $7zipPath

7zip a -mx=9 ".\Releases\Filter_Combinator_$version.zip" "$env:APPDATA\Factorio\mods\Filter_Combinator_$version"