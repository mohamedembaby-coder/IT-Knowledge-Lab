# Read-only DHCP client evidence for incident collection.
param(
    [string]$OutputPath = '.\\dhcp-client-evidence.txt'
)

$items = @(
    '=== Timestamp ===',
    (Get-Date -Format o),
    '=== IP Configuration ===',
    (ipconfig /all | Out-String),
    '=== IPv4 Routes ===',
    (Get-NetRoute -AddressFamily IPv4 | Sort-Object DestinationPrefix, RouteMetric | Format-Table -AutoSize | Out-String),
    '=== DHCP-related System Events ===',
    (Get-WinEvent -LogName System -MaxEvents 200 -ErrorAction SilentlyContinue | Where-Object ProviderName -Match 'Dhcp' | Format-List TimeCreated,Id,LevelDisplayName,Message | Out-String)
)

$items | Set-Content -LiteralPath $OutputPath -Encoding utf8
Write-Output "Evidence written to $OutputPath"
