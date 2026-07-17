# ==========================================
# TemplateManager Module
# IT Knowledge Lab
# ==========================================

function Copy-KLTemplates {

    param(
        [string]$TemplatePath,
        [string]$DestinationPath
    )

    if (!(Test-Path $TemplatePath)) {

        throw "Template folder not found: $TemplatePath"

    }

    Copy-Item `
        -Path (Join-Path $TemplatePath "*") `
        -Destination $DestinationPath `
        -Recurse `
        -Force

    Write-Host "Templates copied successfully." -ForegroundColor Green

}

Export-ModuleMember -Function Copy-KLTemplates