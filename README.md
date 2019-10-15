# Remove-iCloudPhotosShortcut

[![badge-build-azuredevops-build-img][]][badge-build-azuredevops-build-src] [![badge-version-github-release-img][]][badge-version-github-release-src] [![badge-version-powershellgallery-releases-img][]][badge-version-powershellgallery-releases-src]

[badge-build-azuredevops-build-img]: https://img.shields.io/azure-devops/build/joeltimothyoh/Remove-iCloudPhotosShortcut/19/master.svg?label=build&logo=azure-pipelines&style=flat-square
[badge-build-azuredevops-build-src]: https://dev.azure.com/joeltimothyoh/Remove-iCloudPhotosShortcut/_build?definitionId=19
[badge-version-github-release-img]: https://img.shields.io/github/v/release/joeltimothyoh/Remove-iCloudPhotosShortcut?style=flat-square
[badge-version-github-release-src]: https://github.com/joeltimothyoh/Remove-iCloudPhotosShortcut/releases
[badge-version-powershellgallery-releases-img]: https://img.shields.io/powershellgallery/v/Remove-iCloudPhotosShortcut?logo=powershell&logoColor=white&label=PSGallery&labelColor=&style=flat-square
[badge-version-powershellgallery-releases-src]: https://www.powershellgallery.com/packages/Remove-iCloudPhotosShortcut/

A powershell module for removing iCloud Photos shortcuts from *This PC* and *Quick access* on Windows.

## Introduction

iCloud Photos shortcuts are automatically created under *This PC* and *Quick access* in File Explorer on **Windows** each time *iCloud for Windows* is installed or updated, with the former being impossible to remove interactively.

This module attempts to ease removal of the shortcuts by doing so programmatically.

## Requirements

* \***Windows** with [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1).

\**Quick access* management is limited to Windows OS versions **10.0.10240** and higher.

## Installation

First, ensure [`PSGallery`](https://www.poqwershellgallery.com/) is registered as a PowerShell repository:

```powershell
Register-PSRepository -Default -Verbose
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

To update the module (Existing versions are left intact):

```powershell
# Latest
Update-Module -Name Remove-iCloudPhotosShortcut -Verbose

# Specific version
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

# Tip: Simulate uninstalls with -WhatIf
```

### Repositories

To get all registered PowerShell repositories:

```powershell
Get-PSRepository -Verbose
```

To set the installation policy for the `PSGallery` repository:

```powershell
# PSGallery (trusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -Verbose

# PSGallery (untrusted)
Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted -Verbose
```
