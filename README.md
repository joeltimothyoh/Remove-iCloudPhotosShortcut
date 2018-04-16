# Remove-iCloudPhotosShortcut
Removes 'iCloud Photos' listed under 'This PC' in File Explorer on Windows.

## Description
The 'iCloud Photos' shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

The script will:
1. Find the registry key
2. Attempt to remove the registry key

Upon successful removal of the registry key, a message of success will be printed. 'iCloud Photos' should no longer be listed under 'This PC' in File Explorer.

## Usage
Simply manually run, or set the script to run on a schedule.

Note: Editing the registry on Windows requires elevated permissions. Run the script with administrative rights.

## Example
`.\Remove-iCloudPhotosShortcut.ps1`