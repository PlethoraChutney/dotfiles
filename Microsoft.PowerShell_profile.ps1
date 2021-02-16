# powershell environment preferences

# Custom prompt
Set-PsReadLineOption -Colors @{
    'ForegroundColor' = [ConsoleColor]::Green
    'String' = [ConsoleColor]::Blue
    'Parameter' = [ConsoleColor]::Cyan
}
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
$Host.PrivateData.ProgressForegroundColor = 'Green'
$Host.PrivateData.ProgressBackgroundColor = 'Black'

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
  Import-Module posh-git
  # $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
}

function prompt {

    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "Current Folder: $pwd"

    #Configure current user, current folder and date outputs
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();

    # Test for Admin / Elevated
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    #Decorate the CMD Prompt
    $prompt = Write-host ($(if ($IsAdmin) { 'Elevated ' } else { '' })) -ForegroundColor Red -NoNewline
    $prompt += Write-Host "$($CmdPromptUser.Name.split("\")[1]) " -ForegroundColor Green -NoNewline
    $prompt += Write-Host "@ " -ForegroundColor White -NoNewline
    $prompt += Write-Host "Powershell " -NoNewline -ForegroundColor Red
    $prompt += Write-Host $pwd  -ForegroundColor Blue -NoNewline
    # $prompt += & $GitPromptScriptBlock
    $prompt += "> "
    if ($prompt) { "$prompt" } else { " " }
} #end prompt function

# directory traversing
$DOCDIR = [Environment]::GetFolderPath("MyDocuments")
$SCRIPD = "$DOCDIR\Scripts"
$EXPERIMENTDIR = "$DOCDIR\Experiments"

function Go-To-Documents ($target) {
  if($target -eq $null) {
    Set-Location $DOCDIR
  } else {
  Set-Location $DOCDIR\$target*
  }
}

function Go-To-Experiment ($exp_no) {
  if($exp_no -eq $null) {
    Set-Location $EXPERIMENTDIR
  } elseif ([Math]::log10($exp_no) -lt 2) {
    Set-Location $EXPERIMENTDIR\Experiment0$exp_no*
  } else {
    Set-Location $EXPERIMENTDIR\Experiment$exp_no*
  }
}

function Go-To-Scripts ($script_name) {
  if($script_name -eq $null) {
    Set-Location $SCRIPD
  } else {
    Set-Location $SCRIPD\$script_name*
  }
}

function Run-Appia () {
  python $SCRIPD\Appia\appia.py @args
}

function Make-Symlink ($path, $name, $target) {
  New-Item -itemtype symboliclink -path $path -name $name -value $target
}

function Run-Elevated-Powershell () {
  Start-Process PowerShell -Verb RunAs
}

function Force-Remove-Dir ($target_dir) {
  Remove-Item -Force -Recurse $target_dir
}

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
Set-Alias -Name cde -Value Go-To-Experiment
Set-Alias -Name ln -Value Make-Symlink
Set-Alias -Name appia -Value Run-Appia
Set-Alias -Name sudo -Value Run-Elevated-Powershell
Set-Alias -Name appiaenv -Value $SCRIPD\Appia\venv\Scripts\activate.ps1
Set-Alias -Name rmrf -Value Force-Remove-Dir
