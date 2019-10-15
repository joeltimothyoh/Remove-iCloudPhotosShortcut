[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

# Install Pester if needed
"Checking Pester version" | Write-Host
$pesterMinimumVersion = [version]'4.0.0'
$pester = Get-Module 'Pester' -ListAvailable -ErrorAction SilentlyContinue
if (!$pester -or !($pester.Version -gt $pesterMinimumVersion)) {
    "Installing Pester" | Write-Host
    Install-Module -Name 'Pester' -Repository 'PSGallery' -MinimumVersion $pesterMinimumVersion -Scope CurrentUser -Force
}
Get-Module Pester -ListAvailable
