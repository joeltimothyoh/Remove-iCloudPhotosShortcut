<#
.SYNOPSIS
Removes iCloud Photos shortcuts from 'This PC' and 'Quick access' on Windows.

.DESCRIPTION
iCloud Photos shortcuts are automatically created under 'This PC' and 'Quick access' in File Explorer on Windows each time iCloud for Windows is installed or updated, with the former being impossible to remove interactively. This script attempts to ease removal of the shortcuts by doing so programmatically.

.EXAMPLE
.\Remove-iCloudPhotosShortcut.ps1
#>

# Gets registry item(s)
function Get-RegistryItem {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        $Path
    )
    begin {
    }process {
        # Perform for each item
        $Path | % {
            try {
                $_item = $_ | Get-Item -ErrorAction Stop
                if ($_item.PSProvider.Name -ne 'Registry') {
                    throw 'Item found is not a registry key object.'
                }
                $_item
            }catch {
                "$($_.Exception.Message)" | Write-Error
            }
        }
    }
}

# Removes registry item(s)
function Remove-RegistryItem {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        $Path
    )
    begin {
    }process {
        # Perform for each item
        $Path | % {
            try {
                $_item = $_ | Get-Item -ErrorAction Stop
                if ($_item.PSProvider.Name -ne 'Registry') {
                    throw 'Item found is not a registry key object.'
                }
                $_item | Remove-Item -ErrorAction Stop
            }catch {
                "$($_.Exception.Message)" | Write-Error
            }
        }
    }
}

# Gets pinned Quick access items
function Get-QuickAccessItem {
    [CmdletBinding(DefaultParameterSetName='Names')]
    Param(
        [Parameter(ParameterSetName='Names', Mandatory=$True, Position=0)]
        $Name
        ,
        [Parameter(ParameterSetName='Paths', Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        $Path
    )
    begin {
        $_qAObject = New-Object -ComObject shell.application
    }process {
        try {
            $_inputObject = if ($PSBoundParameters['Name']) { $Name }
                            elseif ($PSBoundParameters['Path']) { $Path }
            # Get all pinned Quick access items
            $_qAItem = $_qAObject.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items() | ? { $_.IsFolder -eq $true }
            # Get matching item(s)
            $_inputObject | % {
                try {
                    $_query = $_
                    $_item = if ($PSBoundParameters['Name']) { $_qAItem | ? { $_.Name -like $_query } }
                             elseif ($PSBoundParameters['Path']) { $_qAItem | ? { $_.Path -eq $_query -Or $_.Path -eq $_query.Path } }
                    if (!$_item) {
                        if ($PSBoundParameters['Name']) { throw "Cannot find Quick access item with the name '$($_)'." }
                        elseif ($PSBoundParameters['Path']) { throw "Cannot find Quick access item with the path '$($_)'." }
                    }
                    $_item
                }catch {
                    "$($_.Exception.Message)" | Write-Error
                }
            }
        }catch {
            "$($_.Exception.Message)" | Write-Error
        }
    }
}

# Removes pinned Quick access items
function Remove-QuickAccessItem {
    [CmdletBinding(DefaultParameterSetName='Names')]
    Param(
        [Parameter(ParameterSetName='Names', Mandatory=$True, Position=0)]
        $Name
        ,
        [Parameter(ParameterSetName='Paths', Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        $Path
    )
    begin {
        $_object = New-Object System.Collections.ArrayList
    }process {
        try {
            $_inputObject = if ($PSBoundParameters['Name']) { $Name }
                            elseif ($PSBoundParameters['Path']) { $Path }
            # Get matching item(s)
            $_inputObject | % {
                try {
                    $_item = if ($PSBoundParameters['Name']) { Get-QuickAccessItem -Name $_ -ErrorAction Stop }
                             elseif ($PSBoundParameters['Path']) { Get-QuickAccessItem -Path $_ -ErrorAction Stop }
                    $_item.InvokeVerb("unpinfromhome")      # The method does not return any value. A post-check is necessary to ascertain successful removal
                    $_itemPresent = $_item | Get-QuickAccessItem -ErrorAction SilentlyContinue
                    if ($_itemPresent) { throw "Failed to remove Quick access shortcut '$($_item.Path)'." }
                }catch {
                    "$($_.Exception.Message)" | Write-Error
                }
            }
        }catch {
            "$($_.Exception.Message)" | Write-Error
        }
    }
}

function Remove-iCloudPhotosShortcut {
    [CmdletBinding()]
    Param()
    function Remove-iCloudPhotosThisPCShortcut {
        [CmdletBinding()]
        Param()
        # iCloud Photos This PC shortcut's associated registry key
        [string]$REGISTRY_KEY_PATH = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'
        try {
            "Removing the iCloud Photos This PC shortcut" | Write-Host
            $_registryItem = Get-RegistryItem -Path $REGISTRY_KEY_PATH -ErrorAction Stop
            $_registryItem | Remove-RegistryItem -ErrorAction Stop
            "Successfully removed iCloud Photos This PC shortcut." | Write-Host -ForegroundColor Green
        }catch {
            "Error: $($_.Exception.Message)" | Write-Host -ForegroundColor Yellow
        }
    }
    function Remove-iCloudPhotosQuickAccessShortcut {
        [CmdletBinding()]
        Param()
        # iCloud Photos Quick access shortcut's item path
        [string]$QA_ITEM_PATH = '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}\::{F0D63F85-37EC-4097-B30D-61B4A8917118}'
        try {
            "Removing the iCloud Photos Quick access shortcut" | Write-Host
            $_quickAccessItem = Get-QuickAccessItem -Path $QA_ITEM_PATH -ErrorAction Stop
            $_quickAccessItem | Remove-QuickAccessItem -ErrorAction Stop
            "Successfully removed iCloud Photos Quick access shortcut." | Write-Host -ForegroundColor Green
        }catch {
            "Error: $($_.Exception.Message)" | Write-Host -ForegroundColor Yellow
        }
    }
    Remove-iCloudPhotosThisPCShortcut
    Remove-iCloudPhotosQuickAccessShortcut
}

# Call main function
Remove-iCloudPhotosShortcut