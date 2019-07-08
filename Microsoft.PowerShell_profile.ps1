# powershell environment preferences

Import-Module posh-git

Set-PsReadLineOption -Colors @{
    'ForegroundColor' = [ConsoleColor]::Green
    'String' = [ConsoleColor]::Blue
    'Parameter' = [ConsoleColor]::Cyan
}
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
$Host.PrivateData.ProgressForegroundColor = 'Green'
$Host.PrivateData.ProgressBackgroundColor = 'Black'

# directory traversing
$DOCDIR = [Environment]::GetFolderPath("MyDocuments")
$SCRIPTDIR = "$DOCDIR\Scripts"
$EXPERIMENTDIR = "$DOCDIR\Experiments"

function Go-To-Documents {Set-Location $DOCDIR}
function Go-To-Experiment ($exp_no) {Set-Location $EXPERIMENTDIR\Experiment$exp_no*}
function Go-To-Scripts {Set-Location $SCRIPTDIR}
function Make-Symlink ($path, $name, $target) {New-Item -itemtype symboliclink -path $path -name $name -value $target}

# alias some git unix functions for instinct reasons
function login-gitbash {& 'C:\Program Files\Git\bin\sh.exe' --login}
Set-Alias -Name gitbash -Value login-gitbash
Set-Alias -Name vim -Value 'C:\Program Files\Git\usr\bin\vim.exe'
Set-Alias -Name grep -Value 'C:\Program Files\Git\usr\bin\grep.exe'

# some powershell aliases
Set-Alias -Name which -Value Get-Command
Set-Alias -Name exp -Value Go-To-Experiment
Set-Alias -Name cds -Value Go-To-Scripts
Set-Alias -Name cdd -Value Go-To-Documents
Set-Alias -Name ln -Value Make-Symlink

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
