# Gets pinned Quick access items
function Get-QuickAccessItem {
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
        $_qAObject = New-Object -ComObject shell.application
    }process {
        $_inputObject = if ($PSBoundParameters['Name']) { $PSBoundParameters['Name'] }
                        elseif ($PSBoundParameters['Path']) { $PSBoundParameters['Path'] }
        # Get all pinned Quick access items
        $_qAItem = $_qAObject.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items() | Where-Object { $_.IsFolder -eq $true }
        # Get matching item(s)
        $_inputObject | ForEach-Object {
            $_query = $_
            $_item = if ($PSBoundParameters['Name']) { $_qAItem | Where-Object { $_.Name -like $_query } }
                        elseif ($PSBoundParameters['Path']) { $_qAItem | Where-Object { $_.Path -eq $_query } }
            if (!$_item) {
                if ($PSBoundParameters['Name']) {
                    Write-Error -Exception ([System.Management.Automation.ItemNotFoundException]::New("Cannot find Quick access item with the name '$($_)'."))
                    return
                }
                elseif ($PSBoundParameters['Path']) {
                    Write-Error -Exception ([System.Management.Automation.ItemNotFoundException]::New("Cannot find Quick access item with the path '$($_)'."))
                    return
                }
            }
            $_item
        }
    }
}
