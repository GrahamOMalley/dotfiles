$DEBUG_LOG=$FALSE # could also use Write-Debug, but I prefer colorised output for debug messages
function dbg($msg) { if($DEBUG_LOG) { Write-Host $msg -Fore Green } }

########### VARIABLES
$mymods = "C:\PSModules"
$mypsfiles=@("$profile", "$mymods\gomMisc\gomMisc.psm1", "$mymods\gomSVN\gomSVN.psm1", "$mymods\kaizenSQL\kaizenSQL.psm1")
$env:Path += ";$(Split-Path $profile)\Scripts"
$env:Path += ";C:\Program Files (x86)\PuTTY"

Set-Alias devenv "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Set-Alias svn "C:\Program Files\TortoiseSVN\bin\svn.exe"
Set-Alias python "C:\Python27\python.exe"

########### TERMINAL APPEARANCE
$console = $host.UI.RawUI
$console.BackgroundColor = “Black”
$console.ForegroundColor = “White”

########### HISTORY
function History-Load
{
	$buffer = "#TYPE Microsoft.PowerShell.Commands.HistoryInfo`n"
	$buffer+= "`"Id`",`"CommandLine`",`"ExecutionStatus`",`"StartExecutionTime`",`"EndExecutionTime`"`n"
	$count = 1
	foreach ($line in Get-Content C:\Users\ZK7PJHN\AppData\Roaming\PSReadline\ConsoleHost_history.txt)
	{
		$buffer+="`"$count`", `"$line`", `"Completed`", `"07/05/2015 10:29:10`", `"07/05/2015 10:29:10`"`n"
		$count++
	}

	$buffer > $scr\hist.csv
	Import-Csv $scr\hist.csv | Add-History
	Write-Host -Fore Green "`nLoaded $count history items.`n"
}
History-Load

Write-Host "Importing Module: Pscx " -fore Green
Import-Module "C:\Program Files (x86)\PowerShell Community Extensions\Pscx3\Pscx"

foreach($module in gci $mymods -Exclude 'PowerTab')
{
	Write-Host "Importing Module: $module" -fore Green
	Import-Module -name $module -DisableNameChecking -force
}

Write-Host "Importing Module: PowerTab" -fore Green
Import-Module -name $mymods\PowerTab -DisableNameChecking -ArgumentList C:\working\apps\powertab\PowerTabConfig.xml

########### PSREADLINE
Set-PSReadlineOption -TokenKind Variable -ForegroundColor magenta
Set-PSReadlineOption -TokenKind Command -ForegroundColor Green


########### FUNCTIONS/COMMON ALIASES
function Find-Files { gci -Recurse -name -include $args}
function Open-Explorer{ explorer.exe . }
function ppath{$env:Path -split ';' | Sort}
function Which-Command{get-command $args[0] | format-table -property commandtype, name, pssnapin, module -auto}
function Search-Hist($arg) { Get-History -c $MaximumHistoryCount | out-string -stream | Select-String $arg }
function Search-StringInFiles($arg){ls -Recurse | sls $arg }
function Get-HistoryAll { Get-History -c  $MaximumHistoryCount }
function Kill-All($arg) {Stop-Process -Force -Name $arg}

Set-Alias asys Open-Autosys
Set-Alias ex Open-Explorer
Set-Alias f Find-Files
Set-Alias fd Find-OpenDefault
Set-Alias fs Search-FilesContainingString
Set-Alias fss Search-StringInFiles
Set-Alias fv Find-OpenVim
Set-Alias fvs Find-OpenVS
Set-Alias grep findstr
#Set-Alias h Get-HistoryAll
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
$vimdir = ""
$Pscx:Preferences.TextEditor="$vimdir\vim74\vim.exe"
Set-Alias vim $vimdir\vim74\vim.exe
Set-Alias gvim $vimdir\vim74\gvim.exe
function vimdiff { gvim --remote-tab-silent +"vert diffsplit $($args[0])" $args[1] }
function Open-PSWorkspace{ $mypsfiles | Open-WithVim }
Set-Alias psvim Open-PSWorkspace
Set-Alias vi Open-WithVim

