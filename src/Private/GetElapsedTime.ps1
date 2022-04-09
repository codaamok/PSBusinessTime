function GetElapsedTime {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$StartDate,

        [Parameter(Mandatory)]
        [DateTime]$EndDate,

        [Parameter(Mandatory)]
        [DateTime]$StartOfDay,

        [Parameter(Mandatory)]
        [DateTime]$EndOfDay
    )

    $Subtractor = New-TimeSpan

    $StartOfDayDifference = $StartOfDay.TimeOfDay - $StartDate.TimeOfDay
    if ($StartOfDayDifference -gt 0) {
        $Subtractor += $StartOfDayDifference
    }

    $EndOfDayDifference = $EndDate.TimeOfDay - $EndOfDay.TimeOfDay
    if ($EndOfDayDifference -gt 0) {
        $Subtractor += $EndOfDayDifference
    }

    (New-TimeSpan -Start $StartDate -End $EndDate) - $Subtractor
}