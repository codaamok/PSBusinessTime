function Test-WorkingDay {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$StartDate,

        [Parameter()]
        [DateTime]$StartHour = '08:00:00',

        [Parameter()]
        [DateTime]$FinishHour = '17:00:00',

        [Parameter()]
        [int[]]$NonWorkingDaysOfWeek = @(0,6),

        [Parameter()]
        [DateTime[]]$NonWorkingDates = @()
    )

    $NonWorkingDaysOfWeek -notcontains $StartDate.DayOfWeek -And
    $StartDate.TimeOfDay -ge $StartHour.TimeOfDay -And
    $StartDate.TimeOfDay -lt $FinishHour.TimeOfDay -And
    $NonWorkingDates -notcontains $StartDate.Date
}