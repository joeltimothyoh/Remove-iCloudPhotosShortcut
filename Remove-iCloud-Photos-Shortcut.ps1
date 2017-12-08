<#
.SYNOPSIS
Removes 'iCloud Photos' listed under 'This PC' in File Explorer in Windows.

.DESCRIPTION
The 'iCloud Photos' shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

.EXAMPLE
.\Remove-iCloud-Photos-Shortcut.ps1

#>

function foundkey {
    try {
        # Get the registry key
        $item = Get-Item -Path $key -ErrorAction Stop       # ErrorAction Stop converts this exception from non-terminating to terminating

        # Set flag to true if registry key is found
        $found = $true
    }

    # Handle potential exceptions
    catch {
        $e = $_.Exception.GetType().Name
        if ($e -eq 'ItemNotFoundException') {
            Write-Host "The registry key could not be found." -ForegroundColor Yellow
        }
    }

    # Return true if registry key is found
    if ($found) {
        $true
    }

    # Assume false
    $false
}

function removekey {
    try {
        # Remove the registry key
        Remove-Item -Path $key -ErrorAction Stop        # ErrorAction Stop converts this exception from non-terminating to terminating

        # Set flag to true if registry key is removed
        $success = $true
    } 

    # Handle potential exceptions
    catch {
        $e = $_.Exception.GetType().Name
        if ($e -eq 'SecurityException') {
            Write-Host "The registry key could not be removed due to insufficient priveleges. Run the script with administrative rights." -ForegroundColor Yellow
        }
        if ($e -eq 'ItemNotFoundException') {
            Write-Host "The registry key could not be found." -ForegroundColor Yellow
        }
    }

    # Return true if registry key is removed
    if ($success) {
        $true
    }

    # Assume false
    $false
}

function Remove-iCloud-Photos-Shortcut {

    # Define path to registry key
    $key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

    Write-Host "Finding key..."

    # Begin process of removal of the registry key, printing appropriate status messages
    # Attempt to find the registry key
    if (foundkey) {
        Write-Host "Found key." -ForegroundColor Cyan
        Write-Host "Removing key..."

        # Attempt to remove the registry key
        if (removekey) {
            Write-Host "Removed key." -ForegroundColor Cyan
            Write-Host "Successfully removed iCloud Photos shortcut from This PC." -ForegroundColor Green
        }
        # When the registry key failed to be removed
        else {
            Write-Host "Failed to remove iCloud Photos shortcut from This PC."
        }
    }
    # When the registry key failed to be found
    else {
        Write-Host "The registry key for iCloud Photos shortcut could not be found. Doing nothing."
    }

}

# Call function
Remove-iCloud-Photos-Shortcut