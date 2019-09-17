# Remove-iCloudPhotosShortcut

Removes iCloud Photos shortcuts from 'This PC' and 'Quick access' on Windows.

## Description

iCloud Photos shortcuts are automatically created under *This PC* and *Quick access* in `File Explorer` on **Windows** each time *iCloud for Windows* is installed or updated, with the former being impossible to remove interactively. This script attempts to ease removal of the shortcuts by doing so programmatically.

A message of success will be printed on the successful removal of each shortcut. The shortcuts should no longer appear in `File Explorer`.

## How to use

`Remove-iCloudPhotosShortcut` can be manually executed, or set to run on a schedule.

**Note:** Editing the registry on Windows requires *elevated* permissions. Run the script with administrative rights.

### Example

Runs the `Remove-iCloudPhotosShortcut.ps1` script in an instance of PowerShell.

```powershell
powershell -File "C:\path\to\Remove-iCloudPhotosShortcut.ps1"
```

## Security

Unverified scripts are restricted from running on Windows by default. You can bypass the security errors by overriding the default execution policy of the powershell process like so:

```powershell
powershell -ExecutionPolicy Unrestricted -File "C:\path\to\Remove-iCloudPhotosShortcut.ps1"
```

To view all current execution policies on the system:

```powershell
Get-ExecutionPolicy -List
```

## Requirements

* Windows with [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1).
