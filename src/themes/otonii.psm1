#requires -Version 2 -Modules posh-git

function Write-Theme {
  param(
    [bool]
    $lastCommandFailed
  )

  #check the last command state and indicate if failed
  $promtSymbolColor = [ConsoleColor]::Green
  If ($lastCommandFailed) {
    $promtSymbolColor = [ConsoleColor]::Red
  }

  # Check if the virtualenv is active and 
  if ($_PYTHON_VENV_PROMPT_PREFIX) {
    $prompt +=  Write-Prompt -Object "($_PYTHON_VENV_PROMPT_PREFIX)" -ForegroundColor ([ConsoleColor]::DarkGreen)
  }

  #check for elevated prompt
  If (Test-Administrator) {
    $prompt += Write-Prompt -Object "# " -ForegroundColor([ConsoleColor]::DarkYellow)
  }

  $user = [System.Environment]::UserName
  if (Test-NotDefaultUser($user)) {
    $prompt += Write-Prompt -Object ($user) -ForegroundColor ([ConsoleColor]::Yellow)
    $prompt += Write-Prompt -Object " in " -ForegroundColor ([ConsoleColor]::White)
  }

  # Writes the drive portion
  $drive = '~'
  if ($pwd.Path -ne $HOME) {
    $drive = "$(Split-Path -path $pwd -Leaf)"
  }
  $prompt += Write-Prompt -Object $drive -ForegroundColor ([ConsoleColor]::Cyan)
  
  if (Get-Command Get-GitStatus -errorAction SilentlyContinue) {
    $status = Get-GitStatus
    
    if ($status) {
      $gitIndicator = [char]::ConvertFromUtf32(0xE0A0)
      $prompt += Write-Prompt -Object " on " -ForegroundColor ([ConsoleColor]::White)
      $prompt += Write-Prompt -Object "$($gitIndicator) $($status.Branch) " -ForegroundColor ([ConsoleColor]::Magenta)
	  
      $isClean = $true
      if ($status.Working.Length -gt 0) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x25CF)) -ForegroundColor ([ConsoleColor]::DarkYellow)
        $isClean = $false
      }

      if ($status.HasIndex) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x25CF)) -ForegroundColor ([ConsoleColor]::Green)
        $isClean = $false
      }

      if ($status.HasUntracked) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x25CF)) -ForegroundColor ([ConsoleColor]::Red)
        $isClean = $false
      }

      if ($status.AheadBy -gt 0) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x25B2)) -ForegroundColor ([ConsoleColor]::Cyan)
        $isClean = $false
      }

      if ($status.BehindBy -gt 0) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x25BC)) -ForegroundColor ([ConsoleColor]::Magenta)
        $isClean = $false
      }
	  
      if ($isClean) {
        $prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0x2713)) -ForegroundColor ([ConsoleColor]::Green)
      }
    }
  }

  # Writes the postfix to the prompt
  $PromptIndicator = [char]::ConvertFromUtf32(0x276F)
  $prompt += Write-Prompt -Object " $($PromptIndicator) " -ForegroundColor $promtSymbolColor
  $prompt
}
