Set-PSReadLineOption -EditMode Emacs

# Autocomplete - Teclas de atalho
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Intellisense - Funcionamento
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates

# Configurando cores do prompt
Set-PSReadLineOption -Colors @{
  # The color of the continuation prompt.
  ContinuationPrompt = [ConsoleColor]::White
  # The emphasis color. For example, the matching text when searching history.
  Emphasis           = [ConsoleColor]::Cyan
  # The error color. For example, in the prompt.
  Error              = [ConsoleColor]::Red
  # The color to highlight the menu selection or selected text.
  Selection          = [ConsoleColor]::White
  # The default token color.
  Default            = [ConsoleColor]::White
  # The comment token color.
  Comment            = [ConsoleColor]::DarkGreen
  # The keyword token color.
  Keyword            = [ConsoleColor]::Green
  # The string token color.
  String             = [ConsoleColor]::Yellow
  # The operator token color.
  Operator           = [ConsoleColor]::DarkGray
  # The variable token color.
  Variable           = [ConsoleColor]::Red
  # The command token color.
  Command            = [ConsoleColor]::Green
  # The parameter token color.
  Parameter          = [ConsoleColor]::Cyan
  # The type token color.
  Type               = [ConsoleColor]::White
  # The number token color.
  Number             = [ConsoleColor]::DarkYellow
  # The member name token color.
  Member             = [ConsoleColor]::White
  # The intellisense color.
  InlinePrediction = [ConsoleColor]::DarkGray
}