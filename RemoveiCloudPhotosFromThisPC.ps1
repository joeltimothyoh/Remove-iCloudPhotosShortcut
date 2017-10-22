#############################################################################################################################################
## 1. Running this script will remove 'iCloud Photos' icon from 'This PC' in Windows.                                                      ##
## 2. The icon reappears every time iCloud is updated.                                                                                     ##   
## 3. The following is the full path to the 'iCloud Photos' Registry Key which you can manually remove if necessary:                       ##
##     'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}' ##
#############################################################################################################################################

$key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

function foundkey
{
    $found = $false
    try {
        $item = Get-Item -Path $key -ErrorAction Stop    # Convert exception from non-terminating to terminating
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
        Remove-Item -Path $key -ErrorAction Stop    # Convert exception from non-terminating to terminating
        $success = $true
    } catch {
        $e = $_.Exception.GetType().Name
        if ($e -eq 'SecurityException') {
            Write-Host "Removing the registry key failed because removing a registry key requires elevated permissions. Run this script with administrative rights." -ForegroundColor Yellow
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
    

###############################################################################################################
## For more information, see: https://www.eightforums.com/general-support/35046-remove-icloud-photos-pc.html ##
###############################################################################################################

#########################
## Powershell Commands ##
#########################

#Remove-Item -Path 'HKLM:\SOFTWARE\Test\Key1'                           # This removes key named 'Key1'
#Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Test\Key2' -Name 'hi'        # This removes value named 'hi' in key named 'Key2'
