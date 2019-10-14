# Removes pinned Quick access items
function Remove-QuickAccessItem {
    [CmdletBinding(DefaultParameterSetName='Name')]
    Param(
        [Parameter(ParameterSetName='Name', Mandatory=$True, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name
        ,
        [Parameter(ParameterSetName='Path', Mandatory=$True, ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Path
    )
    begin {
    }process {
        $_inputObject = if ($PSBoundParameters['Name']) { $PSBoundParameters['Name'] }
                        elseif ($PSBoundParameters['Path']) { $PSBoundParameters['Path'] }
        # Remove matching item(s)
        $_inputObject | ForEach-Object {
            try {
                $_item = if ($PSBoundParameters['Name']) { Get-QuickAccessItem -Name $_ -ErrorAction Stop }
                         elseif ($PSBoundParameters['Path']) { Get-QuickAccessItem -Path $_ -ErrorAction Stop }
                $_item.InvokeVerb("unpinfromhome")      # The method does not return any value. A post-check is necessary to ascertain successful removal
                try {
                    $_itemPresent = $_item | Get-QuickAccessItem -ErrorAction Stop
                }catch [System.Management.Automation.ItemNotFoundException]{
                    return
                }
                if ($_itemPresent) {
                    Write-Error -Exception ([System.Management.Automation.RuntimeException]::New("Failed to remove Quick access shortcut '$($_item.Path)'."))
                }
            }catch {
                Write-Error -Exception $_.Exception -Message $_.Exception.Message -Category $_.CategoryInfo.Category
            }
        }
    }
}
