<#
.SYNOPSIS
Removes 'iCloud Photos' listed under 'This PC' in File Explorer in Windows.

.DESCRIPTION
The 'iCloud Photos' shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

.EXAMPLE
.\RemoveiCloudPhotosFromThisPC.ps1

#>

$key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

function foundkey
{
    $found = $false
    try {
        $item = Get-Item -Path $key -ErrorAction Stop                       # ErrorAction Stop converts this exception from non-terminating to terminating
        if ($item) {
            $found = $true
        }
    } catch {
        $e = $_.Exception.GetType().Name            
        if ($e) {
            Write-Host "Finding the registry key failed." -ForegroundColor Yellow
        }
    }
    $found
}

function removekey
{
    try {
        Remove-Item -Path $key -ErrorAction Stop                               
        $success = $true
    } catch {
        $e = $_.Exception.GetType().Name
        if ($e -eq 'SecurityException') {
            Write-Host "Removing the registry key failed because removing a registry key requires elevated privileges. Run this script with administrative rights." -ForegroundColor Yellow
        }
        if ($e -eq 'ItemNotFoundException') {
            Write-Host "Removing the registry key failed because it could not be found." -ForegroundColor Yellow
        }
    }
    if ($success) {
        $true
    }
    $false
}

Write-Host "Finding key..." -ForegroundColor Cyan
if (foundkey) {
    Write-Host "Found key." -ForegroundColor Cyan
    Write-Host "Attempting to remove key..." -ForegroundColor Cyan
    if (removekey) {
        Write-Host "Removed key." -ForegroundColor Cyan
        Write-Host "Successfully removed iCloud Photos from This PC." -ForegroundColor Green
    } else {
        Write-Host "Failed to remove iCloud Photos from This PC."
    }
} else {
    Write-Host "Registry key for removing iCloud Photos from This PC could not be found. Doing nothing."
}
