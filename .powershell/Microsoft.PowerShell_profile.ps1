# VARIABLES
$wpsd = "C:\Users\gom\Documents\WindowsPowerShell"
$env:Path += ";$(Split-Path $profile)\Scripts"

# VIM
$vimdir = "E:\Program Files\Vim\vim74\"
Set-Alias vim $vimdir\vim.exe
Set-Alias gvim $vimdir\gvim.exe

# TERMINAL APPEARANCE
$console = $host.UI.RawUI
$console.BackgroundColor = “Black”
$console.ForegroundColor = “White”

#$buffer = $console.BufferSize
#$buffer.Width = 130
#$buffer.Height = 2000
#$console.BufferSize = $buffer
#$size = $console.WindowSize
#$size.Width = 130
#$size.Height = 50
#$console.WindowSize = $size

function Prompt
{
    $promptString = "PS " + $(Get-Location) + ">"
 
    # Custom color for Windows console
    if ( $Host.Name -eq "ConsoleHost" )
    {
        $loc = "\" + $(Get-Location) + ">"
        Write-Host $env:username -NoNewline -ForegroundColor White
        Write-Host "@" -NoNewline -ForegroundColor Cyan
        Write-Host $env:computername -NoNewline -ForegroundColor White
        Write-Host $loc -NoNewline -ForegroundColor Cyan
    }
    # Default color for the rest
    else
    {
        Write-Host $promptString -NoNewline
    }
 
    return " "
}

function Write-Color-LS
    {
        param ([string]$color = "white", $file)
        Write-host ("{0,-7} {1,25} {2,10} {3}" -f $file.mode, ([String]::Format("{0,10}  {1,8}", $file.LastWriteTime.ToString("d"), $file.LastWriteTime.ToString("t"))), $file.length, $file.name) -foregroundcolor $color 
    }

New-CommandWrapper Out-Default -Process {
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase)


    $compressed = New-Object System.Text.RegularExpressions.Regex(
        '\.(zip|tar|gz|rar|jar|war)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex(
        '\.(exe|bat|cmd|py|pl|ps1|psm1|vbs|rb|reg)$', $regex_opts)
    $text_files = New-Object System.Text.RegularExpressions.Regex(
        '\.(txt|cfg|conf|ini|csv|log|xml|java|c|cpp|cs)$', $regex_opts)

    if(($_ -is [System.IO.DirectoryInfo]) -or ($_ -is [System.IO.FileInfo]))
    {
        if(-not ($notfirst)) 
        {
           $notfirst=$true
        }

        if ($_ -is [System.IO.DirectoryInfo]) 
        {
            Write-Color-LS "Cyan" $_                
        }
        elseif ($compressed.IsMatch($_.Name))
        {
            Write-Color-LS "Red" $_
        }
        elseif ($executable.IsMatch($_.Name))
        {
            Write-Color-LS "Green" $_
        }
        elseif ($text_files.IsMatch($_.Name))
        {
            Write-Color-LS "White" $_
        }
        else
        {
            Write-Color-LS "White" $_
        }

    $_ = $null
    }
} -end {
    write-host ""
}
Set-Alias ll ls

Set-Location C:\
Clear-Host
