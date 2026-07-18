<#
.SYNOPSIS
Returns the template directory.

.DESCRIPTION
Returns the full path to the repository Templates folder.

.OUTPUTS
System.String
#>
function Get-KLTemplateRoot {

    [CmdletBinding()]
    param()

    Write-Verbose "Locating template directory"

    $repositoryRoot = Get-KLRepositoryRoot

    $templateRoot = Join-Path `
        -Path $repositoryRoot `
        -ChildPath "Modules\KnowledgeEngine\Private\Templates"

    if (-not (Test-Path -Path $templateRoot -PathType Container)) {

        throw "Template directory not found."
    }

    return $templateRoot
}

<#
.SYNOPSIS
Returns all template files.

.DESCRIPTION
Retrieves all Markdown template files stored in the
Templates directory.

.OUTPUTS
PSCustomObject
#>
function Get-KLTemplates {

    [CmdletBinding()]
    param()

    Write-Verbose "Retrieving template files"

    $templateRoot = Get-KLTemplateRoot

    $templates = Get-ChildItem `
        -Path $templateRoot `
        -Filter "*.md" `
        -File |
    Sort-Object Name

    return $templates | Select-Object `
        Name,
        FullName,
        Length,
        CreationTime,
        LastWriteTime
}