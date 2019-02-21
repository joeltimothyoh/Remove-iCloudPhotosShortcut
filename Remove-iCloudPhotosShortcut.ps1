<#
.SYNOPSIS
Removes 'iCloud Photos' listed under 'This PC' in File Explorer on Windows.

.DESCRIPTION
The 'iCloud Photos' shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

.EXAMPLE
.\Remove-iCloudPhotosShortcut.ps1
#>

# Gets the specified registry key
function Get-RegistryKey {
    Param(
        [Parameter(Mandatory=$True,Position=0)]
        [string]$Path
    )
    # Get the registry key
    try {
        $item = Get-Item -Path $Path -ErrorAction Stop       # ErrorAction Stop converts this exception from non-terminating to terminating for the handling of exceptions
    }catch {
        "$($_.Exception.Message)" | Write-Host -ForegroundColor Yellow
    }
    if ($item.PSProvider.Name -eq 'Registry') {
        return $item
    }
    'Item found is not a registry key object.' | Write-Error
}

# Removes the specified registry key
function Remove-RegistryKey {
    [CmdletBinding(DefaultParameterSetName='Objects')]
    Param(
        [Parameter(Mandatory=$True, ParameterSetName='Objects', Position=0)]
        [Object]$InputObject
        ,
        [Parameter(Mandatory=$True, ParameterSetName='Paths', Position=0)]
        [String]$Path
    )
    # Remove the registry key
    try {
        $item = if     ($PSBoundParameters['InputObject']) { $InputObject }
                elseif ($PSBoundParameters['Path']) { $Path }
        $item | Remove-Item -ErrorAction Stop        # ErrorAction Stop converts this exception from non-terminating to terminating for the handling of exceptions
        $success = $true
    }catch {
        "$($_.Exception.Message)" | Write-Host -ForegroundColor Yellow
    }
    if ($success) {
        return $true
    }
    $false
}

function Remove-iCloudPhotosShortcut {

    # Registry key responsible for the 'This PC' iCloud Photos Shortcut
    [string]$REGISTRY_KEY_PATH = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

    # Find the registry key
    "Finding the iCloud Shortcut registry key..." | Write-Host
    $registryKeyObj = Get-RegistryKey -Path $REGISTRY_KEY_PATH
    if ($registryKeyObj) {
        "Found key." | Write-Host -ForegroundColor Cyan

        # Attempt to remove the registry key
        "Removing key..." | Write-Host
        if (Remove-RegistryKey -InputObject $registryKeyObj) { "Successfully removed iCloud Photos shortcut from This PC." | Write-Host -ForegroundColor Green }
        else { "Failed to remove iCloud Photos shortcut from This PC." | Write-Host -ForegroundColor Magenta }

    }else {
        "The registry key for iCloud Photos shortcut could not be found. Doing nothing." | Write-Host -ForegroundColor Cyan
    }
}

# Call main function
Remove-iCloudPhotosShortcut