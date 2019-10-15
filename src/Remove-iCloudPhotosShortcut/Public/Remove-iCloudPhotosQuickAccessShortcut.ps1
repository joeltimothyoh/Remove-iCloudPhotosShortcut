function Remove-iCloudPhotosQuickAccessShortcut {
    [CmdletBinding()]
    param()
    if ([System.Environment]::OSVersion.Version -lt [Version]'10.0.10240') {
        "Checking OS version" | Write-Verbose
        Write-Error -Exception ([System.PlatformNotSupportedException]::New("The function is not supported on this version of Windows."))
        return
    }
    # iCloud Photos Quick access shortcut's item path
    [string]$QA_ITEM_PATH = '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}\::{F0D63F85-37EC-4097-B30D-61B4A8917118}'
    try {
        "Removing the iCloud Photos Quick access shortcut" | Write-Verbose
        Remove-QuickAccessItem -Path $QA_ITEM_PATH -ErrorAction Stop
    }catch {
        Write-Error -Exception $_.Exception -Message $_.Exception.Message -Category $_.CategoryInfo.Category
    }
}
