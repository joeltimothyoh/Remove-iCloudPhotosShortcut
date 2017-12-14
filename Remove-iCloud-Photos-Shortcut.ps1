<#
.SYNOPSIS
Removes 'iCloud Photos' listed under 'This PC' in File Explorer on Windows.

.DESCRIPTION
The 'iCloud Photos' shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

.EXAMPLE
.\Remove-iCloud-Photos-Shortcut.ps1

#>

# This function attempts to find the registry key
function Find-Key {

    # Define parameters
    Param(
        [Parameter(Mandatory=$True,Position=0)]
        [string]$key
        )

    try {
        # Get the registry key
        $item = Get-Item -Path $key -ErrorAction Stop       # ErrorAction Stop converts this exception from non-terminating to terminating

        # Set flag as true if registry key is found
        $success = $true

    } catch {
        # Handle potential exceptions by name
        $e = $_.Exception.GetType().Name
        if ($e -eq 'ItemNotFoundException') {
            Write-Host "The registry key could not be found." -ForegroundColor Yellow
        }
    }

    # Return true if registry key is found
    if ($success) {
        return $true
    }

    # Assume false
    $false
}

# This function attempts to remove the registry key
function Remove-Key {

    # Define parameters
    Param(
        [Parameter(Mandatory=$True,Position=0)]
        [string]$key
        )

    try {
        # Remove the registry key
        Remove-Item -Path $key -ErrorAction Stop        # ErrorAction Stop converts this exception from non-terminating to terminating

        # Set flag as true if registry key is removed
        $success = $true

    } catch {
        # Handle potential exceptions by name
        $e = $_.Exception.GetType().Name
        if ($e -eq 'SecurityException') {
            Write-Host "The registry key could not be removed due to insufficient administrator privileges." -ForegroundColor Yellow
        }
        if ($e -eq 'ItemNotFoundException') {
            Write-Host "The registry key could not be found." -ForegroundColor Yellow
        }
    }

    # Return true if registry key is removed
    if ($success) {
        return $true
    }

    # Assume false
    $false
}

function Remove-iCloud-Photos-Shortcut {

    # Define path to registry key
    [string]$key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

    Write-Host "Finding key..."

    # Attempt to find the registry key, then print appropriate status messages of the result
    if (Find-Key $key) {
        Write-Host "Found key." -ForegroundColor Cyan
        Write-Host "Removing key..."

        # Attempt to remove the registry key, then print appropriate status messages of the result
        if (Remove-Key $key) {
            Write-Host "Removed key." -ForegroundColor Cyan
            Write-Host "Successfully removed iCloud Photos shortcut from This PC." -ForegroundColor Green
        } else {
            Write-Host "Failed to remove iCloud Photos shortcut from This PC."
        }
    } else {
        Write-Host "The registry key for iCloud Photos shortcut could not be found. Doing nothing."
    }

}

# Call main function 
Remove-iCloud-Photos-Shortcut