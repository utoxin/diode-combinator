$version = ((Get-Content "info.json" -Raw) | ConvertFrom-Json).version

Remove-Item -path "$env:APPDATA\Factorio\mods\Filter_Combinator_$version\*" -Force -Recurse
Copy-Item -Path "*" -Destination "$env:APPDATA\Factorio\mods\Filter_Combinator_$version" -PassThru -Force -Recurse -Exclude @(".vs", ".gitignore", "deploy.ps1", "README.md", ".git")

Compress-Archive -LiteralPath "$env:APPDATA\Factorio\mods\Filter_Combinator_$version" -DestinationPath ".\Releases\Filter_Combinator_$version.zip" -Update