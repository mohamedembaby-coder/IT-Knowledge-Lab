
# ===========================================
# IT Knowledge Lab Generator
# Main Script
# ===========================================

Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      IT Knowledge Lab Generator"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Loading configuration..." -ForegroundColor Yellow

$configPath = Join-Path $PSScriptRoot "config.json"

if (-not (Test-Path $configPath))
{
    Write-Host "ERROR: config.json not found." -ForegroundColor Red
    exit
}

$config = Get-Content $configPath -Raw | ConvertFrom-Json
# Load Modules
Import-Module "$PSScriptRoot\Modules\FolderGenerator.psm1" -Force

Write-Host ""
Write-Host "Creating Categories..." -ForegroundColor Cyan
Write-Host ""

foreach ($category in $config.categories.PSObject.Properties.Name)
{
    New-KLFolder -Path (Join-Path $PSScriptRoot $category)
}
Write-Host ""
Write-Host "Repository :" $config.repository.name -ForegroundColor Green
Write-Host "Author     :" $config.repository.author -ForegroundColor Green
Write-Host ""
Write-Host "Configuration Loaded Successfully." -ForegroundColor Green