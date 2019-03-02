<#
.SYNOPSIS
Removes iCloud Photos shortcuts from 'This PC' and 'Quick access' on Windows.

.DESCRIPTION
iCloud Photos shortcuts are automatically created under 'This PC' and 'Quick access' in File Explorer on Windows each time iCloud for Windows is installed or updated, with the former being impossible to remove interactively. This script attempts to ease removal of the shortcuts by doing so programmatically.

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
        if ($item.PSProvider.Name -ne 'Registry') {
            'Item found is not a registry key object.' | Write-Error
            return
        }
    }catch {
        "$($_.Exception.Message)" | Write-Host -ForegroundColor Yellow
    }
    $item
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

# Gets matching Quick access items
function Get-QuickAccessItem {
    Param(
        [Parameter(Mandatory=$False,Position=0)]
        [string]$Name
        ,
        [Parameter(Mandatory=$False,Position=1)]
        [string]$Path
    )
    # Get all Quick access items
    $quickAccess = New-Object -ComObject shell.application
    $quickAccessItems = $quickAccess.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items()

    # Filter through items
    $item = if     ($PSBoundParameters['Name'] -And $PSBoundParameters['Path']) { $quickAccessItems | ? { $_.Name -eq $Name -And $_.Path -eq $Path } }
            elseif ($PSBoundParameters['Name']) { $quickAccessItems | ? { $_.Name -eq $Name } }
            elseif ($PSBoundParameters['Path']) { $quickAccessItems | ? { $_.Path -eq $Path } }
    $item
}

# Removes matching Quick access items
function Remove-QuickAccessItem {
    Param(
        [Parameter(Mandatory=$False, Position=0)]
        [string]$Name
        ,
        [Parameter(Mandatory=$False, Position=1)]
        [string]$Path
    )
    # Process parameters for calling
    $params = @{}
    $PSBoundParameters.GetEnumerator() | % {
        $params[$_.Key] = $_.Value
    }

    # Get matching Quick access items
    $item = Get-QuickAccessItem @params
    if (!$item) {
        'No matching Quick access items could be found.' | Write-Error
        return $false
    }

    # Remove matching items
    $item.InvokeVerb("unpinfromhome")       # Does not appear to return an exit code, hence a check after removal is necessary

    # Verify if items have been removed
    $itemPresent = Get-QuickAccessItem @params
    if (!$itemPresent) {
        return $true
    }
    $false
}

function Remove-iCloudPhotosShortcut {
    Param()
    # iCloud Photos This PC shortcut's associated registry key
    [string]$REGISTRY_KEY_PATH = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

    # Find the registry key
    "Removing the iCloud Photos This PC shortcut..." | Write-Host
    $registryKeyObj = Get-RegistryKey -Path $REGISTRY_KEY_PATH
    if ($registryKeyObj) {
        # Attempt to remove the shortcut
        if (Remove-RegistryKey -InputObject $registryKeyObj) {
            "Successfully removed iCloud Photos This PC shortcut." | Write-Host -ForegroundColor Green
        }else { "Failed to remove iCloud Photos This PC shortcut." | Write-Host -ForegroundColor Magenta }
    }else {
        "The iCloud Photos This PC shortcut could not be found. Doing nothing." | Write-Host -ForegroundColor Cyan
    }

    # iCloud Photos Quick access shortcut's item properties
    [string]$QA_ITEM_NAME = 'iCloud Photos'
    [string]$QA_ITEM_PATH = '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}\::{F0D63F85-37EC-4097-B30D-61B4A8917118}'

    # Find the shortcut
    "`nRemoving the iCloud Photos Quick access shortcut..." | Write-Host
    $quickAccessObj = Get-QuickAccessItem -Name $QA_ITEM_NAME -Path $QA_ITEM_PATH
    if ($quickAccessObj) {
        # Attempt to remove the shortcut
        if (Remove-QuickAccessItem -Name $quickAccessObj.Name -Path $quickAccessObj.Path) {
            "Successfully removed iCloud Photos Quick access shortcut." | Write-Host -ForegroundColor Green
        }else { "Failed to remove iCloud Photos Quick access shortcut." | Write-Host -ForegroundColor Magenta }
    }else {
        "The iCloud Photos Quick access shortcut could not be found. Doing nothing." | Write-Host -ForegroundColor Cyan
    }
}

# Call main function
Remove-iCloudPhotosShortcut