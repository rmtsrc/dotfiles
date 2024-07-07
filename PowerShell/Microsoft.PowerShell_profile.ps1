Set-PSReadlineKeyHandler -Chord Alt+F4 -Function ViExit
Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme rudolfs-dark
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -BellStyle Visual
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Invoke-Expression (&starship init powershell)

function Do-Update {
  winget upgrade --all
}

Set-Alias update Do-Update

function Copy-Date-To-Clipboard {
  $full_date = Get-Date -Format "yyyy-MM-dd"
  Set-Clipboard -Value $full_date
}

Set-Alias copy-date Copy-Date-To-Clipboard

Set-Alias pbcopy Set-Clipboard
Set-Alias pbpaste Get-Clipboard

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
