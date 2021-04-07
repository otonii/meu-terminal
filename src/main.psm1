function Test-Administrator {
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Test-NotDefaultUser($user) {
  return $null -eq $DefaultUser -or $user -ne $DefaultUser
}

function Reset-CursorPosition {
  $postion = $host.UI.RawUI.CursorPosition
  $postion.X = 0
  $host.UI.RawUI.CursorPosition = $postion
}

function Set-Theme {
  param(
    [Parameter(Mandatory = $true)]
    [string]
    $name
  )

  $currentThemeLocation = "$PSScriptRoot\themes\$($name).psm1"

  if (Test-Path $currentThemeLocation) {
    Import-Module $currentThemeLocation -Force

    [ScriptBlock]$Prompt = {
      $realLASTEXITCODE = $global:LASTEXITCODE
      $lastCommandFailed = ($global:error.Count -gt $sl.ErrorCount) -or -not $?
      $sl.ErrorCount = $global:error.Count

      Reset-CursorPosition
      $prompt = (Write-Theme -lastCommandFailed $lastCommandFailed)

      # Título da janela
      $location = Get-Location
      $folder = $location.Path
      $folderSplit = $folder -split "$([IO.Path]::DirectorySeparatorChar)", 0, "SimpleMatch"
      if ($folderSplit.length -gt 3) {
        $folder = "$($folderSplit[0])", "...", "$($folderSplit[-2])", "$($folderSplit[-1])" -join "$([IO.Path]::DirectorySeparatorChar)"
      }
      $prompt += "$([char]27)]2;$($folder)$([char]7)"
      if ($location.Provider.Name -eq "FileSystem") {
        $prompt += "$([char]27)]9;9;`"$($location.Path)`"$([char]7)"
      }

      $prompt

      $global:LASTEXITCODE = $realLASTEXITCODE
      Remove-Variable realLASTEXITCODE -Confirm:$false
    }

    Set-Item -Path Function:prompt -Value $Prompt -Force
  }
  else {
    Write-Host ''
    Write-Warning "Theme $name not found. Available themes are:"
    Get-Theme
  }
}

function Get-Theme {
  $themes = @()

  Get-ChildItem -Path "$PSScriptRoot\themes\*" -Include '*.psm1' -Exclude Tools.ps1 | Sort-Object Name | ForEach-Object -Process {
    $themes += [PSCustomObject]@{
      Name = $_.BaseName
    }
  }
  $themes
}

$global:ThemeSettings = New-Object -TypeName PSObject -Property @{
  ErrorCount = 0
}

$sl = $global:ThemeSettings #local settings
$sl.ErrorCount = $global:error.Count
