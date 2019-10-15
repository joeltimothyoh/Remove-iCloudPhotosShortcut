[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$VerbosePreference = 'Continue'

$failedCount = 0

"Function: Remove-iCloudPhotosThisPCShortcut" | Write-Host
try {
    Remove-iCloudPhotosThisPCShortcut -ErrorAction Stop
}catch [System.Management.Automation.ItemNotFoundException] {
    'Success' | Write-Host
}catch {
    $_ | Write-Error
    $failedCount++
}

"Function: Remove-iCloudPhotosQuickAccessShortcut" | Write-Host
try {
    Remove-iCloudPhotosQuickAccessShortcut -ErrorAction Stop
}catch [System.Management.Automation.ItemNotFoundException] {
    'Success' | Write-Host
}catch [System.Management.Automation.RuntimeException] {
    if ([System.Environment]::OSVersion.Version -lt [Version]'10.0.10240') {
        'Success'
    }else {
        throw
    }
    $_ | Write-Error
    $failedCount++
}

if ($failedCount -gt 0) {
    "$failedCount tests failed." | Write-Warning
}
$failedCount
