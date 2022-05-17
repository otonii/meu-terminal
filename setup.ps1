Write-Host "Configurando Terminal - Otonii"

# Instalando módulos necessários
Write-Host "Verificando modulos necessarios"
if ((Get-InstalledModule -Name "posh-git" -RequiredVersion 1.1.0 -ErrorAction SilentlyContinue) -eq $null) {
  Write-Host "Instalando posh-git"
  Install-Module posh-git -RequiredVersion 1.1.0 -Scope CurrentUser -Force -SkipPublisherCheck
}

if ((Get-InstalledModule -Name "PSReadLine" -RequiredVersion 2.1.0 -ErrorAction SilentlyContinue) -eq $null) {
  Write-Host "Instalando PSReadLine"
  Install-Module PSReadLine -RequiredVersion 2.1.0 -Scope CurrentUser -Force -SkipPublisherCheck
}

# Criando pasta do profile caso não exista
if (Test-Path -Path $PROFILE ) {
  # Criando cópia de backup do arquivo atual do $PROFILE
  Copy-Item -Path $PROFILE -Recurse -Destination "$PROFILE.bak" -Force
} else {
  New-Item -Type File -Path $PROFILE -Force
}

# Copiando pastas
$dest = Split-Path $PROFILE
Copy-Item -Path $PSScriptRoot\src -Recurse -Destination $dest -Force

# Copiando conteúdo para o arquivo profile
(get-content "$PSScriptRoot\Profile.ps1" -encoding UTF8) | Out-File -Encoding UTF8 $PROFILE
