# Remove-iCloudPhotosShortcut

Removes iCloud Photos shortcuts from *This PC* and *Quick access* on Windows.

## Description

iCloud Photos shortcuts are automatically created under *This PC* and *Quick access* in `File Explorer` on **Windows** each time *iCloud for Windows* is installed or updated, with the former being impossible to remove interactively. The module attempts to ease removal of the shortcuts by doing so programmatically.

## Installation

First, ensure [`PSGallery`](https://www.powershellgallery.com/) is registered as a PowerShell repository:

```powershell
Register-PSRepository -Default
```

To install the module:

```powershell
# Latest, for the current user
Install-Module -Name Remove-iCloudPhotosShortcut -Repository PSGallery -Scope CurrentUser -Verbose

# Specific version, for the current user
Install-Module -Name Remove-iCloudPhotosShortcut -Repository PSGallery -RequiredVersion x.x.x -Scope CurrentUser -Verbose

# Latest, for all users
Install-Module -Name Remove-iCloudPhotosShortcut -Repository PSGallery -Scope AllUsers -Verbose
```

## Usage

### Functions

To remove the iCloud *Quick access* shortcut:

```powershell
Remove-iCloudPhotosQuickAccessShortcut -Verbose
```

To remove the iCloud *This PC* shortcut (**Requires elevation**):

```powershell
Remove-iCloudPhotosThisPCShortcut -Verbose
```

## Administration

### Module

To import / re-import the module:

```powershell
# Installed version
Import-Module -Name Remove-iCloudPhotosShortcut -Force -Verbose

# Project version
Import-Module .\src\Remove-iCloudPhotosShortcut\Remove-iCloudPhotosShortcut.psm1 -Force -Verbose
```

To remove imported functions of the module:

```powershell
Remove-Module -Name Remove-iCloudPhotosShortcut -Verbose
```

To list imported versions of the module:

```powershell
Get-Module -Name Remove-iCloudPhotosShortcut
```

To list all installed versions of the module available for import:

```powershell
Get-Module -Name Remove-iCloudPhotosShortcut -ListAvailable -Verbose
```

To list versions of the module on `PSGallery`:

```powershell
# Latest
Find-Module -Name Remove-iCloudPhotosShortcut -Repository PSGallery -Verbose

# All versions
Find-Module -Name Remove-iCloudPhotosShortcut -Repository PSGallery -AllVersions -Verbose
```

To update the module:

```powershell
# Latest
Update-Module -Name Remove-iCloudPhotosShortcut -Verbose

# Specific version (Existing versions are left intact)
Update-Module -Name Remove-iCloudPhotosShortcut -RequiredVersion x.x.x -Verbose
```

To uninstall the module:

```powershell
# Latest
Uninstall-Module -Name Remove-iCloudPhotosShortcut -Verbose

# All versions
Uninstall-Module -Name Remove-iCloudPhotosShortcut -AllVersions -Verbose

# To uninstall all other versions other than x.x.x
Get-Module -Name Remove-iCloudPhotosShortcut -ListAvailable | ? { $_.Version -ne 'x.x.x' } | % { Uninstall-Module -Name $_.Name -RequiredVersion $_.Version -Verbose }

# Tip: Use Uninstall-Module -WhatIf to simulate uninstalls
```

### Repositories

To get all registered PowerShell repositories:

```powershell
Get-PSRepository -Verbose
```

To set the installation policy for a repository:

```powershell
# PSGallery (trusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -Verbose

# PSGallery (untrusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted -Verbose
```
