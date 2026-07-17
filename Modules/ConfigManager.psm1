# ==========================================
# ConfigManager Module
# IT Knowledge Lab
# ==========================================

function Get-KLConfiguration {

    param(
        [string]$ConfigPath = ".\config.json"
    )

    if (!(Test-Path $ConfigPath)) {

        throw "Configuration file not found: $ConfigPath"

    }

    return Get-Content $ConfigPath | ConvertFrom-Json

}

Export-ModuleMember -Function Get-KLConfiguration