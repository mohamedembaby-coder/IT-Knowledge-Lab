param(
    [string]$Name = 'app.corp.example',
    [string]$Server
)

$ErrorActionPreference = 'Continue'
Get-Date
Get-DnsClientServerAddress
Get-NetIPConfiguration

if ($Server) {
    Resolve-DnsName -Name $Name -Server $Server -ErrorAction Continue
} else {
    Resolve-DnsName -Name $Name -ErrorAction Continue
}

ipconfig /displaydns
