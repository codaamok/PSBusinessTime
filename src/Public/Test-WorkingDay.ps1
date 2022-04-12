function Test-WorkingDay {
    <#
    .SYNOPSIS
        Determine whether a given datetime is a working day.
    .DESCRIPTION
        Determine whether a given datetime is a working day.
        What constitutes a "working day" in terms of day of the week, or calendar date, including working hours, is arbitrary and completely customisable.
        In other words, the default parameters dictate normal working days, which are Monday through Friday, and normal working hours are 08:00 through 17:00.
        You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.
        If the datetime of -Date falls outside of these parameters, you'll receive a boolean result.
    .PARAMETER Date
        The datetime to determine whether it is a working day or not.
    .PARAMETER StartHour
        The starting hour of a typical working day. The default starting hour is 08:00 (AM).
        Note: this parameter is a datetime object is, however only the time is used for calculation. The date is ignored.
    .PARAMETER FinishHour
        The final hour of a typical working day. The default final hour is 17:00.
        Note: this parameter is a datetime object is, however only the time is used for calculation. The date is ignored.
    .PARAMETER NonWorkingDaysOfWeek
        The days of the week, representated as strings e.g. 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday', which denotes non-working days of the week.
        Days specified in this parameter will not be considered as working days.
    .PARAMETER NonWorkingDates
        An array of datetime objects which denote specific non-working dates.
        Dates specified in this parameter will not be considered as working days.
    .EXAMPLE
        Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00')
        
        The function will return true because the datetime is within the default parameters. 2022-04-11 is a Monday, and 09:00 is between 08:00 and 17:00.
    .EXAMPLE
        Test-WorkingDay -Date (Get-Date '2022-04-10 11:00:00')

        The function will return false because the datetime is outside the default parameters. 2022-04-10 is a Sunday, and therefore is not a working day, regardless of the hour/minute.
    .EXAMPLE
        Test-WorkingDay -Date (Get-Date '2022-04-11 22:00:00') -StartHour (Get-Date '08:00:00') -FinishHour Get-Date '23:00:00'

        The function will return true because the datetime is within the defined parameters. 2022-04-11 is a Monday, and 22:00 is between 08:00 and 23:00.
        Note: a datetime object is passed for both -StartHour and -FinishHour, however only the time is used for calculation. The date is ignored.
    .EXAMPLE
        Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00') -NonWorkingDaysOfWeek 'Saturday','Sunday','Monday'

        The function will return false because the datetime is outside the defined parameters. 2022-04-11 is a Monday, and is considered a non working day of the week.
    .EXAMPLE
        Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00') -NonWorkingDates (Get-Date '2022-04-11')

        The function will return false because the datetime is outside the defined parameters. 2022-04-11 is a Monday, and is considered a non working date.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.Boolean
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$Date,

        [Parameter()]
        [DateTime]$StartHour = '08:00:00',

        [Parameter()]
        [DateTime]$FinishHour = '17:00:00',

        [Parameter()]
        [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')]
        [String[]]$NonWorkingDaysOfWeek = @('Saturday','Sunday'),

        [Parameter()]
        [DateTime[]]$NonWorkingDates
    )

    $NonWorkingDaysOfWeek -notcontains $Date.DayOfWeek -And
    $Date.TimeOfDay -ge $StartHour.TimeOfDay -And
    $Date.TimeOfDay -lt $FinishHour.TimeOfDay -And
    $NonWorkingDates -notcontains $Date.Date
}