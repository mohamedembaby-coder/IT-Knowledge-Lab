function New-KLFile {
    param(
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        New-Item -ItemType File -Path $Path | Out-Null
        Write-Host "[Created] $Path" -ForegroundColor Cyan
    }
    else {
        Write-Host "[Exists ] $Path" -ForegroundColor DarkYellow
    }
}

Export-ModuleMember -Function New-KLFile