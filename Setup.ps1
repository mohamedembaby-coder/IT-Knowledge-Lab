# ==========================================
# IT Knowledge Lab
# Setup.ps1
# Main Entry Point
# ==========================================

Clear-Host

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      IT Knowledge Lab Generator"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ==========================================
# Load Modules
# ==========================================

Import-Module "$PSScriptRoot\Modules\ConfigManager.psm1" -Force
Import-Module "$PSScriptRoot\Modules\ProjectInitializer.psm1" -Force
Import-Module "$PSScriptRoot\Modules\FolderGenerator.psm1" -Force
Import-Module "$PSScriptRoot\Modules\FileGenerator.psm1" -Force
Import-Module "$PSScriptRoot\Modules\TemplateManager.psm1" -Force
Import-Module "$PSScriptRoot\Modules\RepositoryGenerator.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Logger.psm1" -Force

# ==========================================
# Load Configuration
# ==========================================

try {

    Write-KLLog -Message "Loading configuration..." -Level Info

    $config = Get-KLConfiguration

    Write-KLLog -Message "Configuration loaded successfully." -Level Success

}
catch {

    Write-Host ""
    Write-KLLog -Message "ERROR: $($_.Exception.Message)" -Level Error
    exit

}

# ==========================================
# Initialize Project
# ==========================================

Initialize-KnowledgeLab

# ==========================================
# Generate Repository
# ==========================================

New-KLRepository `
    -Config $config `
    -RootPath $PSScriptRoot

# ==========================================
# Finished
# ==========================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "        Process Completed Successfully"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""