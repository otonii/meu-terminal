# Importando módulos
Import-Module -Name posh-git -RequiredVersion 1.1.0
Import-Module -Name PSReadLine -RequiredVersion 2.1.0

Import-Module $PSScriptRoot\src\main.psm1
Import-Module $PSScriptRoot\src\libs\powerls.psm1
Import-Module $PSScriptRoot\src\libs\PowerTouch.psm1

Set-Theme otonii

# Importando configurações do PSReadLine
Import-Module $PSScriptRoot\src\configs\PsReadLineConf.psm1

# Sobrescrevendo a função ls
New-Alias -Name ls -Value PowerLS -Option AllScope -Force

# Custom Touch
New-Alias -Name touch -Value PowerTouch -Option AllScope -Force
