# ==========================================
# Repository Generator Module
# IT Knowledge Lab
# ==========================================

function New-KLRepository {

    <#
    .SYNOPSIS
    Creates complete repository structure based on configuration
    
    .PARAMETER Config
    Configuration object from config.json
    
    .PARAMETER RootPath
    Root path where repository will be created
    #>

    param(
        [Parameter(Mandatory=$true)]
        $Config,
        
        [Parameter(Mandatory=$true)]
        [string]$RootPath
    )

    Write-Host ""
    Write-KLLog -Message "Creating Repository Structure..." -Level Info
    Write-Host ""

    $templatePath = Join-Path $RootPath "Templates"
    $categoryCount = 0
    $topicCount = 0

    foreach ($category in $Config.categories.PSObject.Properties.Name)
    {
        $categoryPath = Join-Path $RootPath $category

        New-KLFolder -Path $categoryPath
        $categoryCount++

        foreach ($topic in $Config.categories.$category)
        {
            $topicPath = Join-Path $categoryPath $topic

            New-KLFolder -Path $topicPath
            $topicCount++

            foreach ($subfolder in $Config.subfolders)
            {
                New-KLFolder -Path (Join-Path $topicPath $subfolder)
            }

            foreach ($file in $Config.lessonFiles)
            {
                New-KLFile -Path (Join-Path $topicPath $file)
            }

            Copy-KLTemplates `
                -TemplatePath $templatePath `
                -DestinationPath $topicPath
        }
    }

    Write-Host ""
    Write-KLLog -Message "==========================================" -Level Success
    Write-KLLog -Message "Repository : $($Config.repository.name)" -Level Success
    Write-KLLog -Message "Author     : $($Config.repository.author)" -Level Success
    Write-KLLog -Message "Categories : $categoryCount" -Level Success
    Write-KLLog -Message "Topics     : $topicCount" -Level Success
    Write-KLLog -Message "Status     : Completed Successfully" -Level Success
    Write-KLLog -Message "==========================================" -Level Success
    Write-Host ""
}

Export-ModuleMember -Function New-KLRepository