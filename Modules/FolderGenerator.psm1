# ==========================================
# FolderGenerator Module
# IT Knowledge Lab
# ==========================================

function New-KLFolder {
    <#
    .SYNOPSIS
    Creates a folder if it doesn't exist
    
    .PARAMETER Path
    Full path to the folder to create
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
        Write-KLLog -Message "[Created] $Path" -Level Success
    }
    else {
        Write-Host "[Exists ] $Path" -ForegroundColor DarkGray
    }
}

Export-ModuleMember -Function New-KLFolder
