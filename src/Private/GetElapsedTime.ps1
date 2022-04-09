function GetElapsedTime {
    [CmdletBinding()]
    param (
        [Parameter()]
        [DateTime]$StartDate,

        [Parameter()]
        [DateTime]$EndDate,

        [Parameter(Mandatory)]
        [DateTime]$StartOfDay,

        [Parameter(Mandatory)]
        [DateTime]$EndOfDay
    )

    $Subtractor = New-TimeSpan

    switch ($PSBoundParameters.Keys) {
        "StartDate" {
            $StartOfDayDifference = $StartOfDay.TimeOfDay - $StartDate.TimeOfDay
            if ($StartOfDayDifference -gt 0) {
                $Subtractor += $StartOfDayDifference
            }
        }
        "EndDate" {
            $EndOfDayDifference = $EndDate.TimeOfDay - $EndOfDay.TimeOfDay
            if ($EndOfDayDifference -gt 0) {
                $Subtractor += $EndOfDayDifference
            }
        }
    }

    (New-TimeSpan -Start $StartDate -End $EndDate) - $Subtractor
}