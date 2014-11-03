$DEBUG_LOG=$FALSE # could also use Write-Debug, but I prefer colorised output for debug messages
function dbg($msg) { if($DEBUG_LOG) { Write-Host $msg -Fore Green } }

########### TERMINAL APPEARANCE
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

########### Persistent History 
$MaximumHistoryCount = 3000
$historyPath = Join-Path (split-path $profile) history.clixml

# Hook powershell's exiting event & hide the registration with -supportevent (from nivot.org)
Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
      # don't save duplicate lines
      Get-History -count $MaximumHistoryCount | Group CommandLine | Foreach {$_.Group[0]} |  Export-Clixml $historyPath
}.GetNewClosure()

# Load previous history, if it exists
if(!(Test-Path variable:global:SETUP_HIST))
{
    dbg("Setting up History")
    if ((Test-Path $historyPath)) {
        $count=0
            Import-Clixml $historyPath | ? {$count++;$true} | Add-History
            Write-Host -Fore Green "`nLoaded $count history item(s).`n"
    }
    Rename-Item Alias:\h original_h -Force
    $SETUP_HIST=$TRUE
}

########### VARIABLES
$mymods = "C:\PSModules"
$mypsfiles=@("$profile", "$mymods\gomMisc\gomMisc.psm1", "$mymods\gomSVN\gomSVN.psm1")
$env:Path += ";$(Split-Path $profile)\Scripts"

$archdir = "H:\Archive\"
$dl = "C:\Users\ZK7PJHN\Downloads"; function dl{cd $dl}
$dta = "C:\Users\ZK7PJHN\Documents\data"
$ftp="\\dfs.uk.ml.com\london\ftp\"
$pshell = "H:\WindowsPowerShell\"
$release = "\\dfs.uk.ml.com\Dublin\DublinSHARED\FinsysDev\FICC Technology (Dublin)\BERTI\Releases"
$rpo = "C:\repos"
# kinda stupid how you can't store a program in a variable?
Set-Alias devenv "C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe"
Set-Alias svn "C:\Program Files\TortoiseSVN\bin\svn.exe"
Set-Alias sqlms "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe"

# Modules Backup is stored on H:
dbg("Importing Modules...")
if(!(Test-Path -path $mymods)){
    Write-Host "Modules Directory not found, creating from last backup..." -ForegroundColor Green
    mkdir $mymods
    $lastModFile = gci $archdir\bm | sort LastWriteTime | select -last 1
    unzip.exe $archdir\bm\$lastModFile -d $mymods
}
Import-Module -name $mymods\Pscx -DisableNameChecking
Import-Module -name $mymods\gomMisc -DisableNameChecking
Import-Module -name $mymods\gomSVN -DisableNameChecking
# TODO: get PS 3.0 or better for this
#Import-Module -name $mymods\PSReadline -DisableNameChecking

########### FUNCTIONS/COMMON ALIASES
function Backup-Modules {pushd $mymods; pkzipc.exe -add -recurse -directories "$($archdir)\bm\modback_$(get-date -f yyyy-MM-dd).zip" *; popd}
function Find-Files { gci -Recurse -name -include $args}
function Open-Explorer{ explorer.exe . }
function ppath{$env:Path -split ';' | Sort}
function ShowTree-All{ Show-Tree -ShowLeaf}
function Which-Command{get-command $args[0] | format-table -property commandtype, name, pssnapin, module -auto}
function Search-Hist($arg) { Get-History -c $MaximumHistoryCount | out-string -stream | Select-String $arg }
function Search-StringInFiles($arg){ls -Recurse | sls $arg }
function Get-HistoryAll { Get-History -c  $MaximumHistoryCount }
function Open-Autosys { Start  "http://autosys.worldnet.ml.com/emea-dev" }
function Kill-All($arg) {Stop-Process -Force -Name $arg}

Set-Alias asys Open-Autosys
Set-Alias bm Backup-Modules
Set-Alias c Clear-Host
Set-Alias ex Open-Explorer
Set-Alias f Find-Files
Set-Alias fs Search-FilesContainingString
Set-Alias fss Search-StringInFiles
Set-Alias fv Find-OpenVim
Set-Alias fd Find-OpenDefault
Set-Alias fvs Find-OpenVS
Set-Alias grep findstr
Set-Alias h Get-HistoryAll
Set-Alias hs Search-Hist
Set-Alias k Kill-All
Set-Alias ll dir
Set-Alias path ppath
Set-Alias p Get-Process
Set-Alias t ShowTree-All
Set-Alias td Show-Tree
Set-Alias which Which-Command
Set-Alias q Exit-PSSession
Set-Alias vs Open-WithVisualStudio
Set-Alias mya Print-MyAliases

# Aliases for web browser from powershell 
# TODO: add some func that opens up all standard work stuff (jira:myissues, etc)
Set-Alias goo Search-Google
Set-Alias js Search-Jira
Set-Alias jira Open-Jira
Set-Alias web Open-Page

########### VIM
$vimdir = "C:\Users\ZK7PJHN\Downloads\vim\"
$Pscx:Preferences.TextEditor="$vimdir\vim74\vim.exe"
Set-Alias vim $vimdir\vim74\vim.exe
Set-Alias gvim $vimdir\vim74\gvim.exe
function vimserver { gvim --remote-tab-silent $args }
function Backup-Vim {pkzipc.exe -add -recurse -directories "$($archdir)\bv\vback_$(get-date -f yyyy-MM-dd).zip" $vimdir\*}
function Open-PSWorkspace{ $mypsfiles | Open-WithVim }
Set-Alias psvim Open-PSWorkspace
Set-Alias vi Open-WithVim
Set-Alias bv Backup-Vim

########### SVN
$repos=@("$rpo\mifid", "$rpo\qzreports", "$rpo\berti\BERTI", "$rpo\berti\BERTI_Web", "$rpo\berti\CMTA")
$svnurls=@("https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk", "https://svn2.worldnet.ml.com/svnrepos/qzreports/qzreports/trunk", "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI/trunk", "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI_Web/trunk", "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI/branches/CMTA/BERTI_DB")
function Svn-UpdateAll{foreach ($repository in $repos){svn update $repository}}
function Svn-StatusAll{foreach ($repository in $repos){svn status $repository}}
function Svn-OpenModifiedVim { Get-SvnModifiedFiles | Open-WithVim }
function Svn-OpenModifiedVS { Get-SvnModifiedFiles | Open-WithVisualStudio }
Set-Alias svaa Svn-AddAll
Set-Alias svf Svn-Find
Set-Alias svl Svn-PPrintXmlLogEntries
Set-Alias svme Svn-GetMyCommits
Set-Alias svsa Svn-StatusAll
Set-Alias svua Svn-UpdateAll
Set-Alias svv Svn-OpenModifiedVim
Set-Alias svvs Svn-OpenModifiedVS
Set-Alias st Svn-PPrintStat

# TODO maybe need some functionality where I can type 'wdex' and save pwd as a persistent directory, and type 'wd' to get back there on startup? or just alias pushd and popd?

# TODO delete anything below this line, only for testing purposes
function tempGo{ cd $rpo\berti\CMTA\BERTI_DB}
Set-Alias rpo tempGo
