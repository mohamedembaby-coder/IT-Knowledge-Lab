# ==========================================
# TemplateManager Module
# IT Knowledge Lab
# ==========================================

function Copy-KLTemplates {

    <#
    .SYNOPSIS
    Copies template files from template folder to destination
    
    .PARAMETER TemplatePath
    Path to the Templates directory
    
    .PARAMETER DestinationPath
    Destination path where templates will be copied
    #>

    param(
        [Parameter(Mandatory=$true)]
        [string]$TemplatePath,
        
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath
    )

    if (!(Test-Path $TemplatePath)) {
        throw "Template folder not found: $TemplatePath"
    }

    if (!(Test-Path $DestinationPath)) {
        throw "Destination folder not found: $DestinationPath"
    }

    $templates = Get-ChildItem -Path $TemplatePath
    if ($templates.Count -eq 0) {
        Write-Warning "No templates found in: $TemplatePath"
        return
    }

    Copy-Item `
        -Path (Join-Path $TemplatePath "*") `
        -Destination $DestinationPath `
        -Recurse `
        -Force | Out-Null

}

Export-ModuleMember -Function Copy-KLTemplates