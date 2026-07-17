# ==========================================
# Repository Generator Module
# IT Knowledge Lab
# ==========================================

function New-KLRepository {

    param(
        $Config,
        $RootPath
    )

    Write-Host ""
    Write-Host "Creating Repository Structure..." -ForegroundColor Cyan
    Write-Host ""

    foreach ($category in $Config.categories.PSObject.Properties.Name)
    {
        $categoryPath = Join-Path $RootPath $category

        New-KLFolder -Path $categoryPath

        foreach ($topic in $Config.categories.$category)
        {
            $topicPath = Join-Path $categoryPath $topic

            New-KLFolder -Path $topicPath

            foreach ($subfolder in $Config.subfolders)
            {
                New-KLFolder -Path (Join-Path $topicPath $subfolder)
            }

            foreach ($file in $Config.lessonFiles)
            {
                New-KLFile -Path (Join-Path $topicPath $file)
            }

            Copy-KLTemplates `
                -TemplatePath (Join-Path $RootPath "Templates") `
                -DestinationPath $topicPath
        }
    }

    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "Repository : $($Config.repository.name)" -ForegroundColor Green
    Write-Host "Author     : $($Config.repository.author)" -ForegroundColor Green
    Write-Host "Status     : Completed Successfully" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host ""
}

Export-ModuleMember -Function New-KLRepository