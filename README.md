# Remove-iCloudPhotosShortcut

Removes 'iCloud Photos' listed under 'This PC' in File Explorer on Windows.

## Description

The 'iCloud Photos' shortcut is automatically listed under 'This PC' in File Explorer every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

## Prodecure

The script does as follows:

1. Finds the registry key
2. Attempts to remove the registry key

Upon successful removal of the registry key, a message of success will be printed. 'iCloud Photos' should no longer be listed under 'This PC' in File Explorer.

## Usage

Execute the script manually, or set it to run on a schedule.

**Note:** Editing the registry on Windows requires elevated permissions. Run the script with administrative rights.

## Example

Runs the `Remove-iCloudPhotosShortcut.ps1` script in an instance of PowerShell.

```powershell
Powershell "C:\path\to\Remove-iCloudPhotosShortcut.ps1"
```

## Security

Unverified scripts are restricted from running on Windows by default. In order to use `Remove-iCloudPhotosShortcut`, you will need to allow the execution of unverified scripts. To do so, open PowerShell as an *Administrator*. Then run the command:

```powershell
Set-ExecutionPolicy Unrestricted -Force
```

If you wish to revert the policy, run the command:

```powershell
Set-ExecutionPolicy Undefined -Force
```

## Requirements

* Windows with <a href="https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1" target="_blank" title="PowerShell">PowerShell</a>.