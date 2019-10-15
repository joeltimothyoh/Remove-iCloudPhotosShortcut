[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$VerbosePreference = 'Continue'
$global:PesterDebugPreference_ShowFullErrors = $true

try {
    # Install test dependencies
    "Installing test dependencies" | Write-Host
    & "$PSScriptRoot\Install-TestDependencies.ps1"

    # Run unit tests
    "Running unit tests" | Write-Host
    $testFailed = $false
    $unitResult = Invoke-Pester -Script "$PSScriptRoot\..\src\Remove-iCloudPhotosShortcut" -PassThru
    if ($unitResult.FailedCount -gt 0) {
        "$($unitResult.FailedCount) tests failed." | Write-Warning
        $testFailed = $true
    }

    # Run integration tests
    "Running integration tests" | Write-Host
    $integratedFailedCount = & "$PSScriptRoot\Run-IntegrationTests.ps1"
    if ($integratedFailedCount -gt 0) {
        $testFailed = $true
    }

    "End of tests" | Write-Host
    if ($testFailed) {
        throw "One or more tests failed."
    }
}catch {
    throw
}
