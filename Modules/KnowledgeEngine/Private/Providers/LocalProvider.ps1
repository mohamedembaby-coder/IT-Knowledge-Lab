#Requires -Version 7.0

Set-StrictMode -Version Latest

# ==========================================
# LocalProvider
# Knowledge Engine - Providers Layer
# ==========================================

<#
.SYNOPSIS
Provides access to the local Knowledge Repository.

.DESCRIPTION
This provider is responsible for discovering and reading
content from the local repository.
#>

function Get-KLRepositoryRoot {

    [CmdletBinding()]
    param()

    Write-Verbose "Locating Knowledge Repository root"

    $currentPath = Get-Location

    while ($null -ne $currentPath) {

        if (Test-Path (Join-Path $currentPath "Modules")) {

            Write-Verbose "Repository root found: $currentPath"

            return $currentPath
        }

        $parent = Split-Path $currentPath -Parent

        if ($parent -eq $currentPath) {
            break
        }

        $currentPath = $parent
    }

    throw "Unable to locate the Knowledge Repository root."
}

function Get-KLCategories {

    [CmdletBinding()]
    param()

    Write-Verbose "Retrieving repository categories"

    $repositoryRoot = Get-KLRepositoryRoot

    $categories = Get-ChildItem `
        -Path $repositoryRoot `
        -Directory |
        Where-Object {
            $_.Name -match '^\d{2}-'
        } |
        Sort-Object Name

    return $categories | Select-Object `
        Name,
        FullName,
        CreationTime,
        LastWriteTime
}

function Get-KLTopics {

    [CmdletBinding()]
    param()

    Write-Verbose "Retrieving repository topics"

    $categories = Get-KLCategories

    $topics = foreach ($category in $categories) {

        Get-ChildItem `
            -Path $category.FullName `
            -Directory |
        Sort-Object Name |
        ForEach-Object {

            [PSCustomObject]@{
                Category      = $category.Name
                Topic         = $_.Name
                FullName      = $_.FullName
                CreationTime  = $_.CreationTime
                LastWriteTime = $_.LastWriteTime
            }

        }

    }

    return $topics
}