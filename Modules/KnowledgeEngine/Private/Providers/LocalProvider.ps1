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
Contains helper functions used to discover and read
content from the local IT Knowledge Lab repository.
#>

<#
.SYNOPSIS
Returns the repository root directory.

.DESCRIPTION
Walks upward from the current location until the
repository root is found.

.OUTPUTS
System.String
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

<#
.SYNOPSIS
Returns all repository categories.

.DESCRIPTION
Returns all top-level folders that follow the naming
convention:

01-Networking
02-Windows
03-Linux

.OUTPUTS
PSCustomObject
#>
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

<#
.SYNOPSIS
Returns all repository topics.

.DESCRIPTION
Enumerates every topic folder inside each category.

.OUTPUTS
PSCustomObject
#>
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

<#
.SYNOPSIS
Returns all Markdown files in the repository.

.DESCRIPTION
Scans every topic folder recursively and returns all
Markdown (.md) files.

.OUTPUTS
PSCustomObject
#>
function Get-KLMarkdownFiles {

    [CmdletBinding()]
    param()

    Write-Verbose "Retrieving Markdown files"

    $topics = Get-KLTopics

    $markdownFiles = foreach ($topic in $topics) {

        Get-ChildItem `
            -Path $topic.FullName `
            -Filter "*.md" `
            -File `
            -Recurse |
        Sort-Object FullName |
        ForEach-Object {

            [PSCustomObject]@{

                Category      = $topic.Category
                Topic         = $topic.Topic

                Name          = $_.Name
                Extension     = $_.Extension

                Directory     = $_.DirectoryName
                FullName      = $_.FullName

                Length        = $_.Length

                CreationTime  = $_.CreationTime
                LastWriteTime = $_.LastWriteTime
            }

        }

    }

    return $markdownFiles
}
<#
.SYNOPSIS
Returns the content of a Markdown file.

.DESCRIPTION
Reads a Markdown file from the Knowledge Repository
and returns its contents as a single string.

.PARAMETER Category
Repository category.

.PARAMETER Topic
Repository topic.

.PARAMETER File
Markdown file name.

.OUTPUTS
System.String
#>
function Get-KLContent {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$Category,

        [Parameter(Mandatory)]
        [string]$Topic,

        [Parameter(Mandatory)]
        [string]$File
    )

    Write-Verbose "Reading repository content"

    $repositoryRoot = Get-KLRepositoryRoot

    $filePath = Join-Path `
        -Path $repositoryRoot `
        -ChildPath $Category

    $filePath = Join-Path `
        -Path $filePath `
        -ChildPath $Topic

    $filePath = Join-Path `
        -Path $filePath `
        -ChildPath $File

    if (-not (Test-Path -Path $filePath -PathType Leaf)) {

        throw "Markdown file not found: $filePath"
    }

    return Get-Content `
        -Path $filePath `
        -Raw `
        -Encoding UTF8
}