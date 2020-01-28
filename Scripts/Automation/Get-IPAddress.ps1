function Get-IPAddress {
    (Get-NetIPAddress |
    ? { ($_.InterfaceAlias -eq 'Wi-Fi') -and ($_.AddressFamily -eq 'IPv4') })[0].IPAddress
}