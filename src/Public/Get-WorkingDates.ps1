function Get-WorkingDates {
    <#
    .SYNOPSIS
        Return all the working dates between two given datetimes.
    .DESCRIPTION
        Return all the working dates between two given datetimes.

        This is helpful to identify the specific dates between two dates which are considered to be "working day(s)".

        What constitutes a "working day" in terms of day of the week, or calendar date, including working hours, is arbitrary and completely customisable.

        In other words, the default parameters dictate normal working days, which are Monday through Friday.

        You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.

        This function does not consider the time, only the date, when determining whether it is a working date or not.
    .PARAMETER StartDate
        The datetime object to identify all the working dates from. It must be an older datetime than -EndDate.
    .PARAMETER EndDate
        The datetime object to identify all the working dates to. It must be a newer datetime than -StartDate.
    .PARAMETER NonWorkingDaysOfWeek
        The days of the week, representated as strings e.g. 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday', which denotes non-working days of the week.
        
        Days specified in this parameter will not be considered as working days.

        Default values are Saturday and Sunday.
    .PARAMETER NonWorkingDates
        An array of datetime objects which denote specific non-working dates.

        Dates specified in this parameter will not be considered as working days.
    .EXAMPLE
        Get-WorkingDates -StartDate (Get-Date '2022-04-11') -EndDate (Get-Date '2022-04-11')
        
        The function will return a datetime object of date '2022-04-11' because '2022-04-11' is considered a working date, as it is a date within the default parameters, and is the only working date within the provided range. '2022-04-11' is a Monday.
    .EXAMPLE
        Get-WorkingDates -StartDate (Get-Date '2022-04-09') -EndDate (Get-Date '2022-04-09')

        The function will not produce any output (null) because '2022-04-09' is not considered a working day within the default parameters and the given range. '2022-04-09' is a Saturday.
    .EXAMPLE
        Get-WorkingDates -StartDate (Get-Date '2022-04-04') -EndDate (Get-Date '2022-04-17')

        The function will return an array of 10 datetime objects for '2022-04-04' through to '2022-04-08', and '2022-04-11' through to '2022-04-15'. These are considered working dates within the default parameters. '2022-04-04' through to '2022-04-08' is Monday through to Friday, and '2022-04-11' through to '2022-04-15' is Monday through to Friday.
    .EXAMPLE
        Get-WorkingDates -StartDate (Get-Date '2022-04-04') -EndDate (Get-Date '2022-04-17') -NonWorkingDates (Get-Date '2022-04-05')

        The function will return an array of 9 datetime objects for '2022-04-04', '2022-04-06' through to '2022-04-08', and and '2022-04-11' through to '2022-04-15'. These are considered working dates within the defined parameters. '2022-04-05' is considered a non-working date, whereas every other date inbetween the range is considered a working date.
    .EXAMPLE
        Get-WorkingDates -StartDate (Get-Date '2022-04-04') -EndDate (Get-Date '2022-04-17') -NonWorkingDaysOfWeek 'Saturday','Sunday','Monday'

        The function will return an array of 8 datetime objects for '2022-04-05' through to '2022-04-08', and '2022-04-12' through to '2022-04-15'. These are considered working dates within the defined parameters. Saturdays, Sundays, and Mondays, are considered non-working days, therefore every other date inbetween the range is considered a working date.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.DateTime[]
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$StartDate,

        [Parameter(Mandatory)]
        [ValidateScript({
            if ($StartDate -gt $_) { throw "-StartDate must be less than -EndDate." } else { return $true }
        })]
        [DateTime]$EndDate,

        [Parameter()]
        [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')]
        [String[]]$NonWorkingDaysOfWeek = @('Saturday','Sunday'),

        [Parameter()]
        [DateTime[]]$NonWorkingDates
    )

    # This can return 1 less than intended if we do not do this change. 
    # For example, if the dates in between are 3 working days,
    # but the time span between them are 2 whole days,
    # this returns 2 instead of 3
    $StartDate = $StartDate.Date
    $EndDate   = $EndDate.Date.AddSeconds(1)

    $TimeSpan = New-TimeSpan -Start $StartDate -End $EndDate
    $Days = [Math]::Ceiling($TimeSpan.TotalDays)
    $Date = $StartDate

    $WorkingDays = do {
        if ($NonWorkingDaysOfWeek -notcontains $Date.DayOfWeek -And $NonWorkingDates -notcontains $Date.Date) {
            $Date.Date
        }
        $Date = $Date.AddDays(1)
        $Days--
    } while ($Days)

    $WorkingDays
}