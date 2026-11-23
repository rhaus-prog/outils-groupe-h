# Installe dwg2dxf pour Windows (LibreDWG 0.13.3, version officielle win64) : quelques secondes.
# Usage (PowerShell) :
#   powershell -ExecutionPolicy Bypass -File outils-groupe-h\dwg\install-windows.ps1
#   & "$env:LOCALAPPDATA\outils-groupe-h\libredwg\dwg2dxf.exe" -y plan.dwg -o plan.dxf
#   python -I outils-groupe-h\dwg\reparer_dxf.py plan.dxf plan.dxf
# Source : page officielle des versions LibreDWG sur GitHub. Aucun binaire n'est stocke dans ce depot.
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$version = '0.13.3'
$dest = Join-Path $env:LOCALAPPDATA 'outils-groupe-h\libredwg'
$exe = Join-Path $dest 'dwg2dxf.exe'
if (Test-Path $exe) { Write-Output "dwg2dxf deja installe : $exe"; exit 0 }
$zip = Join-Path $env:TEMP "libredwg-$version-win64.zip"
$url = "https://github.com/LibreDWG/libredwg/releases/download/$version/libredwg-$version-win64.zip"
Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
$hash = (Get-FileHash $zip -Algorithm SHA256).Hash
if ($hash -ne 'B5133F8B6BD71B7E682A06EF5F99C93B40D628A791C30A31924A80D258C87173') {
    Remove-Item $zip -Force
    throw "Empreinte inattendue pour $url : fichier supprime, installation arretee."
}
New-Item -ItemType Directory -Force $dest | Out-Null
Expand-Archive $zip -DestinationPath $dest -Force
Remove-Item $zip -Force
Write-Output "dwg2dxf installe : $exe"
