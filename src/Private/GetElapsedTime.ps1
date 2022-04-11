function GetElapsedTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$StartDate,

        [Parameter(Mandatory)]
        [DateTime]$EndDate,

        [Parameter(Mandatory)]
        [DateTime]$StartHour,

        [Parameter(Mandatory)]
        [DateTime]$FinishHour
    )

    $Subtractor = New-TimeSpan

    $StartHourDifference = $StartHour.TimeOfDay - $StartDate.TimeOfDay
    if ($StartHourDifference -gt 0) {
        $Subtractor += $StartHourDifference
    }

    $FinishHourDifference = $EndDate.TimeOfDay - $FinishHour.TimeOfDay
    if ($FinishHourDifference -gt 0) {
        $Subtractor += $FinishHourDifference
    }

    (New-TimeSpan -Start $StartDate -End $EndDate) - $Subtractor
}