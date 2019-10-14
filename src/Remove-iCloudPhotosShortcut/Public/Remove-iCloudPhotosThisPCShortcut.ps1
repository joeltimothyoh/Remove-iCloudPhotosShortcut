function Remove-iCloudPhotosThisPCShortcut {
    [CmdletBinding()]
    param()
    # iCloud Photos This PC shortcut's associated registry key
    [string]$REGISTRY_KEY_PATH = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'
    try {
        "Removing the iCloud Photos This PC shortcut" | Write-Verbose
        Remove-Item -Path $REGISTRY_KEY_PATH -ErrorAction Stop
    }catch {
        throw
    }
}
