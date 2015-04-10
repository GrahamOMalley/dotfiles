$DEBUG_LOG=$FALSE # could also use Write-Debug, but I prefer colorised output for debug messages
function dbg($msg) { if($DEBUG_LOG) { Write-Host $msg -Fore Green } }

########### VARIABLES
$mymods = "C:\PSModules"
$mypsfiles=@("$profile", "$mymods\gomMisc\gomMisc.psm1", "$mymods\gomSVN\gomSVN.psm1", "$mymods\kaizenSQL\kaizenSQL.psm1")
$env:Path += ";$(Split-Path $profile)\Scripts"
$env:Path += ";C:\Program Files (x86)\PuTTY"

$archdir = "H:\Archive\"
$apps = "C:\working\apps\"


# kinda stupid how you can't store a program in a variable?
Set-Alias devenv "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Set-Alias svn "C:\Program Files\TortoiseSVN\bin\svn.exe"
Set-Alias sqlms "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe"
Set-Alias python "C:\Python27\python.exe"

########### TERMINAL APPEARANCE
$console = $host.UI.RawUI
$console.BackgroundColor = “Black”
$console.ForegroundColor = “White”
# NOTE: uncomment when not using conEmu
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
      # persist history across multiple sessions
      Import-Clixml $historyPath | Add-History
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
function GFL-Commands {Open-WithVisualStudio C:\repos\scratch\SQLscratch\GFL_commands.sql}
function Straw-Commands {Open-WithVisualStudio C:\repos\scratch\SQLscratch\straw_commands.sql}

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

function Bookmark-Save($bookmark) { $marks["$bookmark"] = (pwd).path; Write-Host "$bookmark" -fore Green -NoNewline; Write-Host ":" -NoNewline; Write-Host "$($marks.$bookmark)" -fore Cyan -NoNewline; Write-Host " added to bookmarks" -fore Green; }
function Bookmark-Delete($bookmark) { if($marks.Contains($bookmark)) { $marks.Remove($bookmark); Write-Host "$bookmark" -fore Green -NoNewline; Write-Host ":" -NoNewline; Write-Host "$($marks.$bookmark)" -fore Cyan -NoNewline; Write-Host " deleted from bookmarks" -fore Magenta; } else { Write-Host "No entry for $bookmark in bookmarks" } }
function Bookmark-Go($number){ cd $marks["$number"] }
function mdump{ $marks.getenumerator() | export-csv $marksPath -notype }
function Bookmark-List{ Write-Host "BookMarks:" -fore Green; $marks.getenumerator() | sort name | % {write-host $_.Name -Fore White -NoNewLine; Write-Host "`t" -NoNewLine; Write-Host $_.Value.Replace("Microsoft.PowerShell.Core\FileSystem::", "") -fore Cyan}}
Set-Alias m Bookmark-Save
Set-Alias g Bookmark-Go
Set-Alias lm Bookmark-List
Set-Alias dm Bookmark-Delete
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


