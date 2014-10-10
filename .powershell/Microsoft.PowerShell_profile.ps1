# TERMINAL APPEARANCE
$console = $host.UI.RawUI
$console.BackgroundColor = “Black”
$console.ForegroundColor = “White”
Clear-Host

$buffer = $console.BufferSize
$buffer.Width = 237
# smaller monitor
$buffer.Width = 190
$buffer.Height = 3000
$console.BufferSize = $buffer
$size = $console.WindowSize
$size.Width = 237
# smaller monitor
$size.Width = 190
$size.Height = 52
$console.WindowSize = $size

# VARIABLES/FUNCTIONS/COMMON ALIASES
# TODO: keep the modules you want as a zip file on the H:. If the folder doesn't exist on C:, unzip them there and import-module them
$env:Path += ";$(Split-Path $profile)\Scripts"
# NOTE: Pscx only seems to work correctly from C:
Import-Module -name C:\PSModules\Pscx -DisableNameChecking
Import-Module H:\WindowsPowerShell\Modules\gomMisc -DisableNameChecking
Import-Module H:\WindowsPowerShell\Modules\gomSVN -DisableNameChecking

$release = "\\dfs.uk.ml.com\Dublin\DublinSHARED\FinsysDev\FICC Technology (Dublin)\BERTI\Releases"
$ftp="\\dfs.uk.ml.com\london\ftp\"
$dl = "C:\Users\ZK7PJHN\Downloads"
$dta = "C:\Users\ZK7PJHN\Documents\data"
$rpo = "C:\repos"
$pshell = "H:\WindowsPowerShell\"
$archdir = "H:\Archive\"

# win32 find.exe is shit. function here to at least give some functionality like unix 'find . -name'
function myfind { Get-ChildItem -Recurse -Force \. -ErrorAction SilentlyContinue | Where-Object { ( $_.Name -like "$args[0]") } | Select-Object Name,Directory| Format-Table -AutoSize * }
function ppath{$env:Path -split ';' | Sort}
function openExplorerHere{ explorer.exe . }
function whichCommand{get-command $args[0] | format-table -property commandtype, name, pssnapin, module -auto}

Set-Alias c clear
Set-Alias ex openExplorerHere
Set-Alias f myfind
Set-Alias ll dir
Set-Alias path ppath
Set-Alias svn "C:\Program Files\TortoiseSVN\bin\svn.exe"
Set-Alias t Show-Tree
Set-Alias which whichCommand

# VIM
$vimdir = "C:\Users\ZK7PJHN\Downloads\vim\"
$Pscx:Preferences.TextEditor="$vimdir\vim74\vim.exe"
Set-Alias vim $vimdir\vim74\vim.exe
Set-Alias gvim $vimdir\vim74\gvim.exe
function vimserver { gvim --remote-tab-silent $args }
function backupVim {pkzipc.exe -add -recurse -directories "$($archdir)vback_$(get-date -f yyyy-MM-dd).zip" $vimdir\*}
Set-Alias vs vimserver
Set-Alias bv backupVim

# SVN
$repos=@("$rpo\mifid", "$rpo\qzreports", "$rpo\berti\BERTI", "$rpo\berti\BERTI_engineering", "$rpo\berti\BERTI_Web")
function getMyCommits{Get-SvnLogCommitData | ? {$_.Author -eq "zk7pjhn"} | pprintSVNCommitLogEntry}
function svnUpdateAllRepos{foreach ($repository in $repos){svn update $repository}}
function svnStatusAllRepos{foreach ($repository in $repos){svn status $repository}}
Set-Alias svme getMyCommits
Set-Alias svf svnFind
Set-Alias svua svnUpdateAllRepos
Set-Alias svsa svnStatusAllRepos

# web browser from powershell 
# TODO: add some func that opens up all standard work stuff (jira:myissues, etc)
Set-Alias goo Search-Google
Set-Alias jsearch Search-Jira
Set-Alias jira Open-Jira
Set-Alias web Open-Page

# TODO delete anything below this line, only for testing purposes
function tempGo{ cd $rpo\mifid\common_scripts}
Set-Alias rpo tempGo
