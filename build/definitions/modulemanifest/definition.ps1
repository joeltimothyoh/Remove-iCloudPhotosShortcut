# - Initial setup: Fill in the GUID value. Generate one by running the command 'New-GUID'. Then fill in all relevant details.
# - Ensure all relevant details are updated prior to publishing each version of the module.
# - To simulate generation of the manifest based on this definition, run the included development entrypoint script Invoke-PSModulePublisher.ps1.
# - To publish the module, tag the associated commit and push the tag.

@{
    RootModule = 'Remove-iCloudPhotosShortcut.psm1'
    # ModuleVersion = ''                            # Value will be set for each publication based on the tag ref. Defaults to '0.0.0' in development environments and regular CI builds
    GUID = '73a9c322-0cc3-4761-b77a-9e5807a02358'
    Author = 'Joel Timothy Oh'
    CompanyName = 'Joel Timothy Oh'
    Copyright = '(c) 2019 Joel Timothy Oh'
    Description = 'Removes iCloud Photos shortcuts from "This PC" and "Quick access" on Windows.'
    PowerShellVersion = '3.0'
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    # RequiredModules = @()
    # RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    # NestedModules = @()
    FunctionsToExport = @(
        'Remove-iCloudPhotosQuickAccessShortcut'
        'Remove-iCloudPhotosThisPCShortcut'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData = @{
        # PSData = @{           # Properties within PSData will be correctly added to the manifest via Update-ModuleManifest without the PSData key. Leave the key commented out.
            Tags = @(
                'icloud'
                'quickaccess'
                'registry'
                'thispc'
            )
            LicenseUri = 'https://raw.githubusercontent.com/joeltimothyoh/Remove-iCloudPhotosShortcut/master/LICENSE'
            ProjectUri = 'https://github.com/joeltimothyoh/Remove-iCloudPhotosShortcut'
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
            # RequireLicenseAcceptance = $false
            # ExternalModuleDependencies = @()
        # }
        # HelpInfoURI = ''
        # DefaultCommandPrefix = ''
    }
}
