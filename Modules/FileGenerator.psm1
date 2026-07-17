# ==========================================
# FileGenerator Module
# IT Knowledge Lab
# ==========================================

function New-KLFile {
    <#
    .SYNOPSIS
    Creates a file if it doesn't exist
    
    .PARAMETER Path
    Full path to the file to create
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        New-Item -ItemType File -Path $Path | Out-Null
        Write-KLLog -Message "[Created] $Path" -Level Success
    }
    else {
        Write-Host "[Exists ] $Path" -ForegroundColor DarkGray
    }
}

Export-ModuleMember -Function New-KLFile