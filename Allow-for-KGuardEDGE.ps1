# Allow-for-KGuardEDGE.ps1
# Requires -RunAsAdministrator

# Fetch domain list from TXT record
$recordName = 'KGuardEDGE.dns.neuralglobal.net'
$domains    = (Resolve-DnsName -Name $recordName -Type TXT).Strings

# Name of the firewall rule
$ruleName = 'Allow for KGuardEDGE'

# Gather IPv4 addresses from DNS for each domain
$currentIPs = foreach ($domain in $domains) {
    try {
        [System.Net.Dns]::GetHostAddresses($domain) |
        Where-Object { $_.AddressFamily -eq 'InterNetwork' } |
        ForEach-Object { $_.IPAddressToString }
    }
    catch {
        Write-Warning "[$domain] DNS resolution error: $_"
    }
}

# Remove duplicate IPs and sort
$currentIPs = $currentIPs | Sort-Object -Unique

if (-not $currentIPs) {
    Write-Error 'No valid IP addresses found; exiting.'
    exit 1
}

# Timestamp for rule description
$timestamp   = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
$description = "Last update: $timestamp"

# Retrieve existing firewall rule
$rule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

if (-not $rule) {
    # Create a new firewall rule
    New-NetFirewallRule `
        -DisplayName   $ruleName `
        -Direction     Inbound `
        -Action        Allow `
        -Protocol      Any `
        -RemoteAddress $currentIPs `
        -Description   $description `
        -EdgeTraversalPolicy Block | Out-Null

    Write-Output "Rule created: $ruleName => $($currentIPs -join ', ')"
}
else {
    # Retrieve existing remote addresses
    $existingIPs = (Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $rule).RemoteAddress
    $oldSet      = [Collections.Generic.HashSet[string]]::new($existingIPs)
    $newSet      = [Collections.Generic.HashSet[string]]::new($currentIPs)

    if (-not $oldSet.SetEquals($newSet)) {
        # Update firewall rule with new IPs
        Set-NetFirewallRule `
            -DisplayName   $ruleName `
            -RemoteAddress $currentIPs `
            -Description   $description

        Write-Output "Rule updated: $ruleName => $($currentIPs -join ', ')"
    }
    else {
        # Only update the description
        Set-NetFirewallRule `
            -DisplayName $ruleName `
            -Description $description

        Write-Output "IPs unchanged; description updated."
    }
}
