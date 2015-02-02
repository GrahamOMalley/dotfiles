$DEBUG_LOG=$FALSE # could also use Write-Debug, but I prefer colorised output for debug messages
function dbg($msg) { if($DEBUG_LOG) { Write-Host $msg -Fore Green } }

########### VARIABLES
$mymods = "C:\PSModules"
$mypsfiles=@("$profile", "$mymods\gomMisc\gomMisc.psm1", "$mymods\gomSVN\gomSVN.psm1", "$mymods\kaizenSQL\kaizenSQL.psm1")
$env:Path += ";$(Split-Path $profile)\Scripts"

$archdir = "H:\Archive\"
$dta = "C:\Users\ZK7PJHN\Documents\data" 
$proj = "C:\working\apps\Visual Studio 2013\Projects"
$vs = "C:\working\apps\Visual Studio 2013"
$ftp="\\dfs.uk.ml.com\london\ftp\"
$pshell = "H:\WindowsPowerShell\"
$berti_rel = "\\dfs.uk.ml.com\Dublin\DublinSHARED\FinsysDev\FICC Technology (Dublin)\BERTI\Releases"
$rpo = "C:\repos"
$apps = "C:\working\apps\"
$nbks= @{
    "zk7pjhn" = "Graham O' Malley";
    "nbk1qqm" = "Mike Wynne";
    "nbkddoz"= "Tim Clewes"
}

# kinda stupid how you can't store a program in a variable?
Set-Alias devenv "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Set-Alias svn "C:\Program Files\TortoiseSVN\bin\svn.exe"
Set-Alias sqlms "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe"
Set-Alias python "C:\Python27\python.exe"

########### TERMINAL APPEARANCE
$console = $host.UI.RawUI
$console.BackgroundColor = “Black”
$console.ForegroundColor = “White”
#Clear-Host
#$buffer = $console.BufferSize
#$buffer.Width = 190
#$buffer.Height = 3000
#$console.BufferSize = $buffer
#$size = $console.WindowSize
#$size.Width = 190
#$size.Height = 52
#$console.WindowSize = $size
# turn on transparency :)
#Import-Module -name $mymods\PTSAeroConsole -DisableNameChecking
#Enable-AeroGlassTheme

# TODO: skip if psversion > 2 and psreadline available
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

function Backup-Apps 
{
    pkzipc.exe -add -recurse -directories "$($archdir)\ba\appsback_$(get-date -f yyyy-MM-dd).zip" $apps\*
    # TODO: sendmail to gomgomgom@gmail.com
}

# Modules Backup is stored on H: (network share) so setup available on any pc I'm logged into
dbg("Importing Modules...")
if(!(Test-Path -path $mymods)){
    Write-Host "Modules Directory not found, creating from last backup..." -ForegroundColor Green
    mkdir $mymods
    $lastModFile = gci $archdir\bm | sort LastWriteTime | select -last 1
    unzip.exe $archdir\bm\$lastModFile -d $mymods
}

Import-Module -name $mymods\Pscx -DisableNameChecking
Import-Module -name $mymods\gomMisc -DisableNameChecking -force #my modules are small and I always want them reloaded when I . $profile
Import-Module -name $mymods\gomSVN -DisableNameChecking -force
Import-Module -name $mymods\kaizenSQL -DisableNameChecking -force
Import-Module -name $mymods\PowerTab -DisableNameChecking -ArgumentList C:\working\apps\powertab\PowerTabConfig.xml

# TODO: get PS 3.0 or better for this
if($PSVersionTable.PSVersion.Major -gt 2){ Import-Module -name $mymods\PSReadline -DisableNameChecking }

########### FUNCTIONS/COMMON ALIASES
function Backup-Modules {pushd $mymods; pkzipc.exe -add -recurse -directories "$($archdir)\bm\modback_$(get-date -f yyyy-MM-dd).zip" *; popd}
function Find-Files { gci -Recurse -name -include $args}
function Open-Explorer{ explorer.exe . }
function ppath{$env:Path -split ';' | Sort}
function Which-Command{get-command $args[0] | format-table -property commandtype, name, pssnapin, module -auto}
function Search-Hist($arg) { Get-History -c $MaximumHistoryCount | out-string -stream | Select-String $arg }
function Search-StringInFiles($arg){ls -Recurse | sls $arg }
function Get-HistoryAll { Get-History -c  $MaximumHistoryCount }
function Open-Autosys { Start  "http://autosys.worldnet.ml.com/emea-dev" }
function Kill-All($arg) {Stop-Process -Force -Name $arg}

Set-Alias asys Open-Autosys
Set-Alias bapps Backup-Apps
Set-Alias bm Backup-Modules
Set-Alias c Clear-Host
Set-Alias ex Open-Explorer
Set-Alias f Find-Files
Set-Alias fd Find-OpenDefault
Set-Alias fs Search-FilesContainingString
Set-Alias fss Search-StringInFiles
Set-Alias fv Find-OpenVim
Set-Alias fvs Find-OpenVS
Set-Alias grep findstr
Set-Alias h Get-HistoryAll
Set-Alias hs Search-Hist
Set-Alias i Invoke-History
Set-Alias k Kill-All
Set-Alias ll dir
Set-Alias mya Print-MyAliases
Set-Alias p Get-Process
Set-Alias path ppath
Set-Alias q Sql-Query
Set-Alias t ShowTree-All
Set-Alias td Show-Tree
Set-Alias vs Open-WithVisualStudio
Set-Alias which Which-Command

# Aliases for web browser from powershell 
# TODO: add some func that opens up all standard work stuff (jira:myissues, etc)
Set-Alias goo Search-Google
Set-Alias js Search-Jira
Set-Alias jira Open-Jira
Set-Alias web Open-Page

########## BOOKMARKS
$marks = @{};
$marksPath = Join-Path (split-path -parent $profile) .bookmarks

function Bookmark-Save($number) { $marks["$number"] = (pwd).path; Write-Host "$number" -fore Green -NoNewline; Write-Host ":" -NoNewline; Write-Host "$($marks.$number)" -fore Cyan -NoNewline; Write-Host " added to bookmarks" -fore Green; }
function Bookmark-Go($number){ cd $marks["$number"] }
function mdump{ $marks.getenumerator() | export-csv $marksPath -notype }
function Bookmark-List{ Write-Host "BookMarks:" -fore Green; $marks.getenumerator() | sort name | % {write-host $_.Name -Fore White -NoNewLine; Write-Host "`t" -NoNewLine; Write-Host $_.Value.Replace("Microsoft.PowerShell.Core\FileSystem::", "") -fore Cyan}}
Set-Alias m Bookmark-Save
Set-Alias g Bookmark-Go
Set-Alias lm Bookmark-List
# NOTE: optionally use powertab completion for the $marks hashtable!
Register-TabExpansion "Bookmark-Go" -Type Command {
    param($Context, [ref]$TabExpansionHasOutput, [ref]$QuoteSpaces) 
    $Argument = $Context.Argument
    $TabExpansionHasOutput.Value = $true
    $marks.keys | Where-Object {$_ -like "$Argument*"} | Sort-Object
}


Register-EngineEvent PowerShell.Exiting –Action { mdump } | out-null
if(test-path $marksPath){ import-csv $marksPath | %{$marks[$_.key]=$_.value}; Write-Host ""; lm }

########### VIM
$vimdir = "C:\working\apps\vim\"
$Pscx:Preferences.TextEditor="$vimdir\vim74\vim.exe"
Set-Alias vim $vimdir\vim74\vim.exe
Set-Alias gvim $vimdir\vim74\gvim.exe
function vimdiff { gvim --remote-tab-silent +"vert diffsplit $($args[0])" $args[1] }
function Open-PSWorkspace{ $mypsfiles | Open-WithVim }
Set-Alias psvim Open-PSWorkspace
Set-Alias vi Open-WithVim

########### SVN

$repos=@{
    #"$rpo\mifid" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk";
    "$rpo\mifid\ExTRA3.5" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk/ExTRA3.5";
    "$rpo\mifid\common_scripts" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk/common_scripts";
    "$rpo\mifid\GFL" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk/GFL";
    "$rpo\mifid\InfoDebt" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk/InfoDebt";
    "$rpo\mifid\straw" = "https://svn.worldnet.ml.com/svnrepos/mifid/mifid/trunk/straw";
    "$rpo\qzreports" = "https://svn2.worldnet.ml.com/svnrepos/qzreports/qzreports/trunk";
    "$rpo\berti\BERTI"= "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI/trunk";
    "$rpo\berti\BERTI_Web"= "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI_Web/trunk";
    "$rpo\berti\CMTA"= "https://svn.worldnet.ml.com/svnrepos/gmistemea_ficc/BERTI/branches/CMTA/BERTI_DB"
}
if(!(Test-Path -path $rpo)){
    Write-Host "SVN working dir not found!" -ForegroundColor Red
    $createrepos= Read-Host "Create SVN Repositories? (Y/N)"
    switch($createrepos)
    {
        Y {
            mkdir $rpo
            $repos.keys | % { 
            mkdir $_ | Out-Null
            svn co $repos.$_ $_
            } 
        }
        default {Write-Host "skipping"}
    }
}

function Svn-UpdateAll{foreach ($repository in $repos.keys){svn update $repository}}
function Svn-StatusAll{foreach ($repository in $repos.keys){ Write-Host "$($repository):" -fore Green ;Svn-PPrintStat $repository; Write-host ""}}
function Svn-OpenModifiedVim { Svn-GetModifiedFiles | Open-WithVim }
function Svn-OpenModifiedVS { Svn-GetModifiedFiles | Open-WithVisualStudio }
Set-Alias svaa Svn-AddAll
Set-Alias svf Svn-Find
Set-Alias svl Svn-PPrintXmlLogEntries
Set-Alias svme Svn-GetMyCommits
Set-Alias svsa Svn-StatusAll
Set-Alias svua Svn-UpdateAll
Set-Alias svv Svn-OpenModifiedVim
Set-Alias svvs Svn-OpenModifiedVS
Set-Alias st Svn-PPrintStat
Set-Alias sta Svn-StatusAll
Set-Alias svd Svn-PPrintDiff

########### JENKINS
$jenkdir = $apps+"jenkins\"
function jenkins {java -jar $jenkdir\jenkins-cli.jar -s http://wcamm03ue.emea.bankofamerica.com:8080/ $args }
Set-Alias jk jenkins

########## Finally

# importing sql modules chucks you into the sql commandline, which doesn't work because of corporate permissions nonsense, so start in my scratch dir instead
cd C:\repos\scratch


