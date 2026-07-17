function New-KLFolder {

    param(
        [string]$Path
    )

    if (-not (Test-Path $Path)) {

        New-Item `
            -ItemType Directory `
            -Path $Path `
            -Force | Out-Null

        Write-Host "[Created] $Path" -ForegroundColor Green

    }
    else {

        Write-Host "[Exists ] $Path" -ForegroundColor Yellow

    }

}

Export-ModuleMember -Function New-KLFolder