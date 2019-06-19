# powershell environment preferences
Set-PSReadlineOption -TokenKind Parameter -ForegroundColor Blue
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Import-Module posh-git

$SCRIPTDIR = 'C:\Users\rich\Documents\Scripts'
$EXPERIMENTDIR = 'C:\Users\rich\Documents\Baconguis_Lab\Experiments'

function Go-To-Experiment ($exp_no) {Set-Location $EXPERIMENTDIR\Experiment$exp_no*}
function Go-To-Scripts {Set-Location $SCRIPTDIR}

# alias some git unix functions for instinct reasons
function login-gitbash {& 'C:\Program Files\Git\bin\sh.exe' --login}
Set-Alias -Name gitbash -Value login-gitbash
Set-Alias -Name vim -Value 'C:\Program Files\Git\usr\bin\vim.exe'
Set-Alias -Name grep -Value 'C:\Program Files\Git\usr\bin\grep.exe'

# some powershell aliases
Set-Alias -Name which -Value Get-Command
Set-Alias -Name exp -Value Go-To-Experiment
Set-Alias -Name cds -Value Go-To-Scripts

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
