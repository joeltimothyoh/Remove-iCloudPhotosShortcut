[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$VerbosePreference = 'Continue'

$failedCount = 0

"Function: Remove-iCloudPhotosThisPCShortcut" | Write-Host
try {
    Remove-iCloudPhotosThisPCShortcut
}catch [System.Management.Automation.ItemNotFoundException] {
    'Success'
}catch {
    $_ | Write-Error
    $failedCount++
}

"Function: Remove-iCloudPhotosQuickAccessShortcut" | Write-Host
try {
    Remove-iCloudPhotosQuickAccessShortcut
}catch [System.Management.Automation.ItemNotFoundException] {
    'Success'
}catch {
    $_ | Write-Error
    $failedCount++
}

"Test Results:" | Write-Host
if ($failedCount -gt 0) {
    "$failedCount tests failed." | Write-Warning
}
$failedCount
