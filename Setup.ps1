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

# ==========================================
# Load Configuration
# ==========================================

try {

    $config = Get-KLConfiguration

}
catch {

    Write-Host ""
    Write-Host "ERROR: $_" -ForegroundColor Red
    exit

}

# ==========================================
# Initialize Project
# ==========================================

Initialize-KnowledgeLab

Write-Host ""
Write-Host "Creating Repository Structure..." -ForegroundColor Cyan
Write-Host ""

# ==========================================
# Generate Categories
# ==========================================

foreach ($category in $config.categories.PSObject.Properties.Name)
{

    $categoryPath = Join-Path $PSScriptRoot $category

    New-KLFolder -Path $categoryPath

    foreach ($topic in $config.categories.$category)
    {

        $topicPath = Join-Path $categoryPath $topic

        New-KLFolder -Path $topicPath

        foreach ($subfolder in $config.subfolders)
        {

            New-KLFolder -Path (Join-Path $topicPath $subfolder)

        }

        foreach ($file in $config.lessonFiles)
        {

            New-KLFile -Path (Join-Path $topicPath $file)

        }

        Copy-KLTemplates `
            -TemplatePath "$PSScriptRoot\Templates" `
            -DestinationPath $topicPath

    }

}

# ==========================================
# Summary
# ==========================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "Repository : $($config.repository.name)" -ForegroundColor Green
Write-Host "Author     : $($config.repository.author)" -ForegroundColor Green
Write-Host "Status     : Completed Successfully" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""